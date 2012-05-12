//
//  NewVentTypeViewController.h
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

@interface FeedbackTypeController : TTViewController {
	
    NSString	*productId;
	UIImage		*image;
	BOOL		ownsItem;
    DBProductFeedback *_feedback;
}

@property (nonatomic, retain) NSString *productId;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) BOOL ownsItem;


- (IBAction)innovationWasClicked;
- (IBAction)commentWasClicked;
- (IBAction)problemWasClicked;

@end
