//
//  GorillaCab Mobile App
//
//  Created by Nelson Melo on 5/11/12.
//  Copyright 2012 CodeModLabs LLC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PassengerConfirmationController : UIViewController
{
    UIButton *acceptButton;
}

@property (nonatomic, retain) UIButton *acceptButton;
- (IBAction)accept_OnClick;
- (IBAction)pass_OnClick;

@end
