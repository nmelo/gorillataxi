//
//  DBUser.h
//  Frankly
//
//  Created by Nelson Melo on 4/26/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@class DBCompanyFeedback, DBProductFeedback, DBVote;
@protocol DBUserAuthenticationDelegate;

@interface DBUser : RKManagedObject<RKObjectLoaderDelegate> {

	NSObject<DBUserAuthenticationDelegate>* _delegate;
}

@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSNumber * facebook_id;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * birth_year;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSSet * company_feedbacks;
@property (nonatomic, retain) NSSet * product_feedbacks;
@property (nonatomic, retain) NSSet * votes;


@property (nonatomic, assign) NSObject<DBUserAuthenticationDelegate>* delegate;
@property (nonatomic, retain) NSString* singleAccessToken;

////////////////////////////////////////////////////////////////////////////////////////////////
+ (DBUser*)currentUser;
- (void)signUpWithDelegate:(NSObject<DBUserAuthenticationDelegate>*)delegate;
- (void)loginWithFacebookId:(NSString*)facebookId delegate:(NSObject<DBUserAuthenticationDelegate>*)delegate;
- (BOOL)isLoggedIn;
- (void)logout;
- (BOOL)isNewRecord;

@property (nonatomic, retain) DBUser* user;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
extern NSString* const DBUserDidLoginNotification; // Posted when the User logs in
extern NSString* const DBUserDidLogoutNotification; // Posted when the User logs out

//Defines the protocol that will inform the consumer of this object of lifecycle events. 
@protocol DBUserAuthenticationDelegate
@optional
- (void)userDidSignUp:(DBUser*)user;
- (void)user:(DBUser*)user didFailSignUpWithError:(NSError*)error;
- (void)userDidLogin:(DBUser*)user;
- (void)user:(DBUser*)user didFailLoginWithError:(NSError*)error;
- (void)userDidNotExist:(DBUser*)user;
- (void)userDidLogout:(DBUser*)user;
@end
