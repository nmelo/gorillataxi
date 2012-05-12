//
//  SignUpViewController.h
//  MobileFeedback
//
//  Created by Ralph Tavarez on 3/16/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "FBConnect.h"
#import "FBLoginButton.h"

#import "AppDelegate.h"
#import "JSONHelper.h"
#import "LeaveFeedbackController.h"
#import "DBUser.h"

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>


@interface SignUpController : TTViewController <FBSessionDelegate, FBRequestDelegate, DBUserAuthenticationDelegate> {

	FBLoginButton       *fbButton;
    UIButton            *createButton;
    NSDictionary        *loginResults;
}

@property (nonatomic, retain) FBLoginButton *fbButton;
@property (nonatomic, retain) UIButton *createButton;
@property (nonatomic, retain) NSDictionary *loginResults;
- (IBAction)useFacebook:(id)sender;

@end
