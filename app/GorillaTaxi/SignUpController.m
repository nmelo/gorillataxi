//
//  SignUpViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 3/16/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "SignUpController.h"

@implementation SignUpController

@synthesize fbButton,createButton, loginResults;


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
	if ((self = [super initWithNavigatorURL:URL query:query])) {
        self.hidesBottomBarWhenPushed = YES;   
    }
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSobject
- (void)dealloc {
    [super dealloc];
	[fbButton release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController
- (void)loadView {
    [super loadView];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
    
    UIImage* background = [UIImage imageNamed:@"GC_background_login.png"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	[headerBackgroundImage setImage:background];
    [self.view addSubview:headerBackgroundImage];
    [self.view sendSubviewToBack:headerBackgroundImage];
    
    UIImage* create_image = [UIImage imageNamed:@"create_app.png"];
    self.createButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.createButton.frame = CGRectMake(500, 325, 92, 129);
    [self.createButton setBackgroundImage:create_image forState:UIControlStateNormal];
    [self.view addSubview:createButton];
    
    self.fbButton = [[FBLoginButton alloc] initWithFrame:CGRectMake(60, 325, 200, 47)];
    [self.view addSubview:fbButton];
    
    self.fbButton.isLoggedIn = NO;
	[fbButton updateImage];
    
    [self.fbButton addTarget:self action:@selector(useFacebook:) forControlEvents:UIControlEventTouchUpInside];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Facebook
- (IBAction)useFacebook:(id)sender {

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Facebook *fbInstance = app.facebook;
    
	if (fbButton.isLoggedIn) {
		
        [fbInstance logout:self];
        
	} else {
		NSArray* permissions = 
			[[NSArray arrayWithObjects: 
			  @"email", @"user_birthday", @"publish_stream", nil] retain];
	
		[fbInstance authorize:permissions delegate:self];
	}
}
- (void)fbDidLogin {
	fbButton.isLoggedIn = YES;
	[fbButton updateImage];
	
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[app.facebook requestWithGraphPath:@"me" andDelegate:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// Facebook notifiying us that the login failed
- (void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"Did not login");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// Facebook notifiying us that the user logged out
- (void)fbDidLogout {
	fbButton.isLoggedIn = NO;
	[fbButton updateImage];
}

- (void)sendUserToHomepage {
    
    //I already have you logged-in, you can continue. 
    TTOpenURL(@"db://home");
}

- (void)sendUserToLeaveFeedback {
    TTOpenURL(@"db://leaveFeedback");
}

-(DBUser*) setupUser {
    
    DBUser *user = [DBUser currentUser];
    
    //Initialize all data for the current user 
    user.first_name  =  [loginResults objectForKey:@"first_name"];
    user.last_name = [loginResults objectForKey:@"last_name"];
    user.email =  [loginResults objectForKey:@"email"];
    user.gender = [[[loginResults objectForKey:@"gender"] substringToIndex:1] uppercaseString];
    //newUser.created_at = [NSDate date];
    //newUser.updated_at = [NSDate date];
    
    //Parsing facebook_id from string
    NSString* facebook_id = [loginResults objectForKey:@"id"];
    user.facebook_id = (NSNumber*)[[[[NSNumberFormatter alloc] init] autorelease] numberFromString:facebook_id];
    
    //Parsing birth_year from string
    NSString* birth_year = [[loginResults objectForKey:@"birthday"] substringFromIndex:6];
    user.birth_year = (NSNumber*)[[[[NSNumberFormatter alloc] init] autorelease] numberFromString:birth_year];
    
    return user;
}

- (void) signup {
    
    DBUser * user = [self setupUser];
    //Using the signup functionality built into DBUser.
    [user signUpWithDelegate:self];

}
///////////////////////////////////////////////////////////////////////////////////////////////////
// Facebook just finished authenticating the user
- (void)request:(FBRequest *)request didLoad:(id)result {
   
    loginResults = (NSDictionary*)result;
    [result retain];

    NSString* facebook_id = [loginResults objectForKey:@"id"];    
    
//    DBUser *currentUser = [DBUser currentUser];
//    currentUser.delegate = self;
//    
//    if([currentUser isNewRecord]){

        //Check the user exists on Rails. 
//        [currentUser loginWithFacebookId:facebook_id delegate:self]; 
//    }
//    else {
        [self sendUserToHomepage];
//    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//RKObjectLoaderDelegate
- (void)userDidLogin:(DBUser*)user {
    [self sendUserToHomepage];
}

- (void)userDidNotExist:(DBUser*)user {
    [self signup];
}

- (void)userDidSignUp:(DBUser*)user {
    [self sendUserToLeaveFeedback];
}

- (void)user:(DBUser*)user didFailSignUpWithError:(NSError*)error {	
    TTAlert([error localizedDescription]);
}

- (void)user:(DBUser*)user didFailLoginWithError:(NSError*)error {
    [[[[UIAlertView alloc] initWithTitle:@"Error"
								 message:[error localizedDescription]
								delegate:nil
					   cancelButtonTitle:@"OK"
					   otherButtonTitles:nil] autorelease] show];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//Facebook Request failed.
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" 
														 message:[error description]
														delegate:self 
											   cancelButtonTitle:@"Okay" 
											   otherButtonTitles:nil];

	[errorAlert show];
	[errorAlert release];
}



@end
