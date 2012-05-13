//
//  GorillaCab Mobile App
//
//  Created by Nelson Melo on 5/11/12.
//  Copyright 2012 CodeModLabs LLC. All rights reserved.
//


#import "RideConfirmationController.h"

@implementation RideConfirmationController

@synthesize acceptButton;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}

- (void)loadView {
	[super loadView];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIImage* backgroundImage = [UIImage imageNamed:@"background_screen3.png"];
	UIImageView* background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[background setImage:backgroundImage];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];

    UIImage* header = [UIImage imageNamed:@"header.png"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
	[headerBackgroundImage setImage:header];
    [self.view addSubview:headerBackgroundImage];
    
    UIImage* dialog = [UIImage imageNamed:@"dialog.png"];
	UIImageView* dialogBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 85, 194, 141)];
	[dialogBackgroundImage setImage:dialog];
    [self.view addSubview:dialogBackgroundImage];
    
    UIImage* confirmationImage = [UIImage imageNamed:@"rideconfirmation.png"];
    UIImageView* confirmation = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 119, 11)];
	[confirmation setImage:confirmationImage];
    [self.view addSubview:confirmation];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 160, 140)];
    label.numberOfLines = 6;
    label.text = @"You’re about ride with Joe to 123 Main St, Miami FL 33146\nOnce you Confirm you’re expected to arrive.";
    [label setFont:[UIFont fontWithName:@"ArialMT" size:11]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label];
    
    UIImage* faceImage = [UIImage imageNamed:@"face.png"];
    UIImageView* face = [[UIImageView alloc] initWithFrame:CGRectMake(143, 230,33, 54)];
	[face setImage:faceImage];
    [self.view addSubview:face];
        
    UIImage* drive_image = [UIImage imageNamed:@"letsroll.png"];
    UIButton* letsGoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    letsGoButton.frame = CGRectMake(60, 310, 203, 48);
    [letsGoButton setBackgroundImage:drive_image forState:UIControlStateNormal];
    [letsGoButton  addTarget:self action:@selector(confirm_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:letsGoButton];

}


- (void)viewDidUnload {
    [super viewDidUnload];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void)confirm_OnClick {
//    TTOpenURL(@"db://newProduct");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {

}


@end
