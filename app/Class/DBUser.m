//
//  DBUser.m
//  Frankly
//
//  Created by Nelson Melo on 4/26/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import "DBUser.h"

//Constants
static NSString* const kDBUserCurrentUserIDDefaultsKey = @"kDBUserCurrentUserIDDefaultsKey";

// Notifications
NSString* const DBUserDidLoginNotification = @"DBUserDidLoginNotification";
NSString* const DBUserDidFailLoginNotification = @"DBUserDidFailLoginNotification";
NSString* const DBUserDidLogoutNotification = @"DBUserDidLogoutNotification";

// Current User singleton
static DBUser* currentUser = nil;

@implementation DBUser

@dynamic first_name;
@dynamic last_name;
@dynamic facebook_id;
@dynamic email;
@dynamic gender;
@dynamic birth_year;
@dynamic created_at;
@dynamic updated_at;
@dynamic user_id;
@dynamic company_feedbacks;
@dynamic product_feedbacks;
@dynamic votes;

@synthesize delegate = _delegate;
@dynamic singleAccessToken;
@dynamic user;

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
            @"created_at", @"created_at",
            @"updated_at", @"updated_at",
            @"id", @"user_id",
            @"gender", @"gender",
            @"last_name", @"last_name",
            @"birth_year", @"birth_year",
            @"first_name", @"first_name",
            @"email", @"email",
            @"facebook_id", @"facebook_id",
			nil];
}
+ (NSString*)primaryKeyProperty {
	return @"user_id";
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
+ (DBUser*)currentUser {
	if (nil == currentUser) {
		id userID = [[NSUserDefaults standardUserDefaults] objectForKey:kDBUserCurrentUserIDDefaultsKey];
		if (userID) {
			currentUser = [self objectWithPrimaryKeyValue:userID];
		} else {
			currentUser = [self object];
		}
		
		[currentUser retain];
	}
	
	return currentUser;
}
+ (void)setCurrentUser:(DBUser*)user {
	[user retain];
	[currentUser release];
	currentUser = user;
}
- (void)signUpWithDelegate:(NSObject<DBUserAuthenticationDelegate>*)delegate {
	_delegate = delegate;
	[[RKObjectManager sharedManager] postObject:self delegate:self];
}
- (void)loginWithFacebookId:(NSString*)facebookId delegate:(NSObject<DBUserAuthenticationDelegate>*)delegate {
	_delegate = delegate;
	
	RKObjectLoader* objectLoader = [[RKObjectManager sharedManager] objectLoaderWithResourcePath:@"/android_users/get_by_facebook_id.json" delegate:self];
	objectLoader.method = RKRequestMethodPOST;
	objectLoader.params = [NSDictionary dictionaryWithKeysAndObjects:@"android_user[facebook_id]", facebookId, nil];	
	objectLoader.targetObject = self;
	[objectLoader send];
}
- (void)logout {	
	RKObjectLoader* objectLoader = [[RKObjectManager sharedManager] objectLoaderWithResourcePath:@"/logout" delegate:self];
	objectLoader.method = RKRequestMethodPOST;
	objectLoader.targetObject = self;
	[objectLoader send];
}
- (void)loginWasSuccessful {
	// Upon login, we become the current user
	[DBUser setCurrentUser:self];
	
	// Persist the UserID for recovery later
	[[NSUserDefaults standardUserDefaults] setObject:self.user_id forKey:kDBUserCurrentUserIDDefaultsKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	// Inform the delegate
	if ([self.delegate respondsToSelector:@selector(userDidLogin:)]) {
		[self.delegate userDidLogin:self];
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:DBUserDidLoginNotification object:self];
}

- (void) userNotExistant {
    
    // Inform the delegate
	if ([self.delegate respondsToSelector:@selector(userDidNotExist:)]) {
		[self.delegate userDidNotExist:self];
	}
}
- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray *)objects {
	// NOTE: We don't need objects because self is the target of the mapping operation
	
	if ([objectLoader wasSentToResourcePath:@"/android_users/get_by_facebook_id.json"]) {

        if(((DBUser*)[objects objectAtIndex:0]).first_name)
        {
            // Login was successful
            [self loginWasSuccessful];
        }
        else
        {
            //user did not exist
            [self userNotExistant];
        }
	} else if ([objectLoader wasSentToResourcePath:@"/android_users"]) { 
		// Sign Up was successful
		if ([self.delegate respondsToSelector:@selector(userDidSignUp:)]) {
			[self.delegate userDidSignUp:self];
		}
		
		// Complete the login as well
		[self loginWasSuccessful];		
	} else if ([objectLoader wasSentToResourcePath:@"/logout"]) {
		// Logout was successful
        
		// Clear the stored credentials
		[[NSUserDefaults standardUserDefaults] setValue:nil forKey:kDBUserCurrentUserIDDefaultsKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
        
		// Inform the delegate
		if ([self.delegate respondsToSelector:@selector(userDidLogout:)]) {
			[self.delegate userDidLogout:self];
		}
		
		[[NSNotificationCenter defaultCenter] postNotificationName:DBUserDidLogoutNotification object:nil];
	}
}
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError*)error {	
	if ([objectLoader wasSentToResourcePath:@"//android_users/get_by_facebook_id.json"]) {
		// Login failed
		if ([self.delegate respondsToSelector:@selector(user:didFailLoginWithError:)]) {
			[self.delegate user:self didFailLoginWithError:error];
		}
	} else if ([objectLoader wasSentToResourcePath:@"/android_users"]) {
		// Sign Up failed
		if ([self.delegate respondsToSelector:@selector(user:didFailSignUpWithError:)]) {
			[self.delegate user:self didFailSignUpWithError:error];
		}
	}
}
- (BOOL)isLoggedIn {
	return self.singleAccessToken != nil;
}
- (BOOL)isNewRecord {
	return [[self primaryKeyValue] intValue] == 0;
}
- (BOOL)canModifyObject:(DBUser*)object {
	if ([object isNewRecord]) {
		return YES;
	} else if ([self isLoggedIn] && [self isEqual:object.user]) {
		return YES;
	} else {
		return NO;
	}
}
- (void)dealloc {
	_delegate = nil;
	[super dealloc];
}

@end
