//
//  NewProductViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "DriverConfirmationController.h"

@implementation DriverConfirmationController

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
    label.text = @"Joe needs a ride to 123 Main St, Miami FL 33146.";
    [label setFont:[UIFont fontWithName:@"ArialMT" size:11]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:label];
    
    UIImage* faceImage = [UIImage imageNamed:@"face.png"];
    UIImageView* face = [[UIImageView alloc] initWithFrame:CGRectMake(143, 230,33, 54)];
	[face setImage:faceImage];
    [self.view addSubview:face];
        
    UIImage* acceptImage = [UIImage imageNamed:@"accept.png"];
    UIButton* accept = [UIButton buttonWithType:UIButtonTypeCustom];
    accept.frame = CGRectMake(60, 310, 203, 48);
    [accept setBackgroundImage:acceptImage forState:UIControlStateNormal];
    [accept  addTarget:self action:@selector(accept_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accept];
    
    UIImage* passImage = [UIImage imageNamed:@"pass.png"];
    UIButton* pass = [UIButton buttonWithType:UIButtonTypeCustom];
    pass.frame = CGRectMake(60, 370, 203, 48);
    [pass setBackgroundImage:passImage forState:UIControlStateNormal];
    [pass  addTarget:self action:@selector(pass_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pass];

}


- (void)viewDidUnload {
    [super viewDidUnload];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void)accept_OnClick {
    TTOpenURL(@"db://newProduct");
}
- (void)pass_OnClick {
    TTOpenURL(@"db://newProduct");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
}


@end
