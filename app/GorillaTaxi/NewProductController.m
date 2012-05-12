//
//  NewProductViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "NewProductController.h"

@implementation NewProductController

@synthesize acceptButton;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}

- (void)loadView {
	[super loadView];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIImage* background = [UIImage imageNamed:@"background.jpg"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	[headerBackgroundImage setImage:background];
    [self.view addSubview:headerBackgroundImage];
    [self.view sendSubviewToBack:headerBackgroundImage];

    UIImage* accept_image = [UIImage imageNamed:@"accept.png"];
    self.acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.acceptButton.frame = CGRectMake(60, 260, 133, 38);
    [self.acceptButton setBackgroundImage:accept_image forState:UIControlStateNormal];
    [self.acceptButton  addTarget:self action:@selector(accept_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:acceptButton];

}

- (void)accept_OnClick {
    TTOpenURL(@"db://confirm");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
}


@end
