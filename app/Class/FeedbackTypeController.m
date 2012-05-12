//
//  NewVentTypeViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/17/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "FeedbackTypeController.h"
#import "FeedbackTextController.h"


@implementation FeedbackTypeController

@synthesize productId;
@synthesize image;
@synthesize ownsItem;

///////////////////////////////////////////////////////////////////////////////////////////////////
// Init
- (id)initWithFeedbackID:(NSString*) feedback_id {
	if ((self = [super init])) {
        
        _feedback = [[DBProductFeedback objectWithPrimaryKeyValue:feedback_id] retain];

        self.hidesBottomBarWhenPushed = YES;   
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (void)loadView {
    [super loadView];

    self.title = @"Type";
    
    self.navigationBarTintColor = [UIColor blackColor]; 
    
    UIImage * backgroundImage = [UIImage imageNamed:@"striped_back.jpg"];
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    self.view.backgroundColor = backgroundColor; 
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = backgroundColor;
    
    
    UIButton *innovationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    innovationButton.frame = CGRectMake(10, 60, 300, 100);
    [innovationButton setImage:[UIImage imageNamed:@"innovation_on.png"] forState:UIControlStateNormal];
    [innovationButton setImage:[UIImage imageNamed:@"innovation_off.png"] forState:UIControlStateHighlighted];
    [innovationButton setImage:[UIImage imageNamed:@"innovation_off.png"] forState:UIControlStateSelected];
    innovationButton.titleLabel.textColor = [UIColor blueColor];
    innovationButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];   
    [innovationButton addTarget:self action:@selector(innovationWasClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:innovationButton];
    
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(10, 140, 300, 100);
    [commentButton setImage:[UIImage imageNamed:@"comment_on.png"] forState:UIControlStateNormal];
    [commentButton setImage:[UIImage imageNamed:@"comment_off.png"] forState:UIControlStateHighlighted];
    [commentButton setImage:[UIImage imageNamed:@"comment_off.png"] forState:UIControlStateSelected];
    commentButton.titleLabel.textColor = [UIColor blueColor];
    commentButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];   
    [commentButton addTarget:self action:@selector(commentWasClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentButton];

    
    UIButton *problemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    problemButton.frame = CGRectMake(10, 220, 300, 100);
    [problemButton setImage:[UIImage imageNamed:@"problem_on.png"] forState:UIControlStateNormal];
    [problemButton setImage:[UIImage imageNamed:@"problem_off.png"] forState:UIControlStateHighlighted];
    [problemButton setImage:[UIImage imageNamed:@"problem_off.png"] forState:UIControlStateSelected];
    problemButton.titleLabel.textColor = [UIColor blueColor];
    problemButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:17];   
    [problemButton addTarget:self action:@selector(problemWasClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:problemButton];
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frankly_logo_bigger.png"]];
    logo.frame = CGRectMake(10, 300, 300, 100);
    [self.view addSubview:logo];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (IBAction)innovationWasClicked {
	
	_feedback.feedback_type = [NSNumber numberWithInt:1]; 
    NSString *URL = RKMakePathWithObject(@"db://feedbackText/(feedback_id)", _feedback);
	TTOpenURL(URL);
}
- (IBAction)commentWasClicked {

    _feedback.feedback_type = [NSNumber numberWithInt:2];
    NSString *URL = RKMakePathWithObject(@"db://feedbackText/(feedback_id)", _feedback);
	TTOpenURL(URL);
	
}
- (IBAction)problemWasClicked {
	_feedback.feedback_type = [NSNumber numberWithInt:3];
    NSString *URL = RKMakePathWithObject(@"db://feedbackText/(feedback_id)", _feedback);
	TTOpenURL(URL);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSobject
- (void)dealloc {
    [super dealloc];
	
	[productId release];
	[image release];
}

@end
