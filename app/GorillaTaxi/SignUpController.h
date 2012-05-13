//
//  GorillaCab Mobile App
//
//  Created by Nelson Melo on 5/11/12.
//  Copyright 2012 CodeModLabs LLC. All rights reserved.
//


#import "FBConnect.h"
#import "FBLoginButton.h"

#import "AppDelegate.h"


@interface SignUpController : UIViewController <FBSessionDelegate, FBRequestDelegate> {

	FBLoginButton       *fbButton;
    UIButton            *createButton;
    NSDictionary        *loginResults;
}

@property (nonatomic, retain) FBLoginButton *fbButton;
@property (nonatomic, retain) UIButton *createButton;
@property (nonatomic, retain) NSDictionary *loginResults;
- (IBAction)useFacebook:(id)sender;

@end
