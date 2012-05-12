//
//  LeaveFeedbackController.m
//  Frankly
//
//  Created by Nelson Melo on 5/2/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import "LeaveFeedbackController.h"


@implementation LeaveFeedbackController

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
	if ((self = [super initWithNavigatorURL:URL query:query])) {
        self.hidesBottomBarWhenPushed = YES;   

    }
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController
- (void)loadView {
    [super loadView];
    
    self.navigationController.navigationBar.hidden = YES; 
    
    //Setup background
    UIImage * backgroundImage = [UIImage imageNamed:@"screen5.jpg"];
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    self.view.backgroundColor = backgroundColor; 
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = backgroundColor;
    
    //Creating Submit button
    UIButton *leaveFeedbackButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leaveFeedbackButton.frame = CGRectMake(10, 275, 300, 100);
    [leaveFeedbackButton setImage:[UIImage imageNamed:@"started_on.png"] forState:UIControlStateNormal];
    [leaveFeedbackButton setImage:[UIImage imageNamed:@"started_off.png"] forState:UIControlStateHighlighted];
    [leaveFeedbackButton setImage:[UIImage imageNamed:@"started_off.png"] forState:UIControlStateSelected];
    [leaveFeedbackButton addTarget:self action:@selector(leaveFeedbacktWasClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leaveFeedbackButton];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void)leaveFeedbacktWasClicked {

    TTOpenURL(@"db://new");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSobject
- (void)dealloc {
    [super dealloc];
}



@end
