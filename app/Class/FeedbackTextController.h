//
//  NewVentTextViewController.h
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/17/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>
#import "DBProductFeedback.h"

@interface FeedbackTextController : TTViewController <UITextViewDelegate, UIAlertViewDelegate, RKObjectLoaderDelegate> 
{
    
	UITextField	*feedbackContentTextView;
    UISwitch    *shareSwitch;
    UILabel     *shareFacebookLabel;
	
	NSString	*productId;
	UIImage		*image;
	BOOL		ownsItem;
	NSString	*type;
    NSString    *userID;
    
    CGFloat animatedDistance;
    
    DBProductFeedback *_feedback; 
}

@property (nonatomic, retain) IBOutlet UITextField *feedbackContentTextView;

@property (nonatomic, retain) NSString *productId;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) BOOL ownsItem;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString    *userID;

- (void)submitWasClicked;

@end
