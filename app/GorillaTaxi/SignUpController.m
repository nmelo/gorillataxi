//
//  GorillaCab Mobile App
//
//  Created by Nelson Melo on 5/11/12.
//  Copyright 2012 CodeModLabs LLC. All rights reserved.
//

#import "SignUpController.h"

@implementation SignUpController

@synthesize fbButton,createButton, loginResults;


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)init {
	if ((self = [super init])) {
        self.hidesBottomBarWhenPushed = YES;   
    }
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSobject
- (void)dealloc {
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
    
    self.fbButton = [[FBLoginButton alloc] initWithFrame:CGRectMake(42, 345, 238, 54)];
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
			[NSArray arrayWithObjects: 
			  @"email", @"user_birthday", @"publish_stream", nil];
	
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

///////////////////////////////////////////////////////////////////////////////////////////////////
// Facebook just finished authenticating the user
- (void)request:(FBRequest *)request didLoad:(id)result {
   
    loginResults = (NSDictionary*)result;

    NSString* facebook_id = [loginResults objectForKey:@"id"];    
    
//    DBUser *currentUser = [DBUser currentUser];
//    currentUser.delegate = self;
//    
//    if([currentUser isNewRecord]){

        //Check the user exists on Rails. 
//        [currentUser loginWithFacebookId:facebook_id delegate:self]; 
//    }
//    else {
        
//    }
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
}



@end
