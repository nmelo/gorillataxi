//
//  NewVentTextViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/17/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "FeedbackTextController.h"
#import "JSONHelper.h"
#import "QSStrings.h"

@implementation FeedbackTextController

@synthesize feedbackContentTextView, productId, image, ownsItem, type, userID;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

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
// UIViewController
- (void)loadView {
    [super loadView];

    self.title = @"Comment";
    
    self.navigationBarTintColor = [UIColor blackColor]; 
    
    UIImage * backgroundImage = [UIImage imageNamed:@"striped_back.jpg"];
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    self.view.backgroundColor = backgroundColor; 
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = backgroundColor;
    

    feedbackContentTextView = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 280, 80)];
    feedbackContentTextView.font = [UIFont systemFontOfSize:14];
    feedbackContentTextView.backgroundColor = [UIColor whiteColor];
    feedbackContentTextView.returnKeyType = UIReturnKeyDone;
    feedbackContentTextView.enablesReturnKeyAutomatically = TRUE;
    [self.view addSubview:feedbackContentTextView];
    [self.feedbackContentTextView addTarget:self
                                     action:@selector(textFieldFinished:)
                           forControlEvents:UIControlEventEditingDidEndOnExit];

    shareFacebookLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 123, 200, 21)];
    shareFacebookLabel.text = @"Share on Facebook";
    shareFacebookLabel.backgroundColor = [UIColor clearColor];
    shareFacebookLabel.font = [UIFont fontWithName:@"Helvetica" size:17];   
    [self.view addSubview:shareFacebookLabel];

    shareSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(206, 120, 94, 27)];
    shareSwitch.backgroundColor = [UIColor clearColor];
    [shareSwitch setOn:TRUE animated:TRUE];
    [self.view addSubview:shareSwitch];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(13, 160, 290, 41);
    [submitButton setImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitWasClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

- (void)submitWasClicked {
	
	if ([feedbackContentTextView.text length] > 0) {

        [feedbackContentTextView resignFirstResponder];
 
        //Get the comments from the textView
        _feedback.content = feedbackContentTextView.text;
        
        //Post object to the server
        [[RKObjectManager sharedManager] postObject:_feedback delegate:self]; 
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//RKObjectLoaderDelegate
- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	
    //If we are coming from a new feedback posted. 
    if(_feedback != nil) {
    
        //Show the alert notifiying feedback was posted. 
        [[[[UIAlertView alloc] initWithTitle:@"Success" 
                                     message:@"Feedback Received."
                                    delegate:self 
                           cancelButtonTitle:@"Dismiss" 
                           otherButtonTitles:@"Review more",nil] autorelease] show];
    }
}
- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
	[[[[UIAlertView alloc] initWithTitle:@"Error" 
								 message:[error localizedDescription] 
								delegate:nil 
					   cancelButtonTitle:@"OK" 
					   otherButtonTitles:nil] autorelease] show];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0){
        //Dismiss was clicked
        [self.navigationController popToRootViewControllerAnimated: YES];        
        
	} else {
        UINavigationController *navigationController = self.navigationController; 
        NSArray *viewControllers = navigationController.viewControllers; 
        int controllersInPileCount = [viewControllers count]; 
        int index = controllersInPileCount - 3; 
        if (index > 0) { 
            UIViewController *popingToThisController = [viewControllers objectAtIndex:index]; 
            if (popingToThisController != nil) { 
                [navigationController popToViewController:popingToThisController animated:false]; 
            } 
        } 

	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// UITextFieldDelegate
- (void)textViewDidBeginEditing:(UITextView *)textField {
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
	CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    
	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
	CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0) {
		heightFraction = 0.0;
	} else if (heightFraction > 1.0) {
		heightFraction = 1.0;
	}
	
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
		animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
	} else {
		animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
	}
	
	CGRect viewFrame = self.view.frame;
    
	viewFrame.origin.y -= animatedDistance;
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
	[self.view setFrame:viewFrame];
    
	[UIView commitAnimations];
}
- (void)textViewDidEndEditing:(UITextView *)textField {
	CGRect viewFrame = self.view.frame;
    
	viewFrame.origin.y += animatedDistance;
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
	[self.view setFrame:viewFrame];
    
	[UIView commitAnimations];
}
- (BOOL)textViewShouldReturn:(UITextView *)textField {
	[feedbackContentTextView resignFirstResponder];
	
	return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
	
	[feedbackContentTextView release];
	[productId release];
	[image release];
	[type release];
}


@end
