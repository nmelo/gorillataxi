//
//  NewProductViewController.h
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>

@interface DriverConfirmationController : TTViewController
{
    UIButton *acceptButton;
}

@property (nonatomic, retain) UIButton *acceptButton;
- (IBAction)accept_OnClick;
- (IBAction)pass_OnClick;


@end
