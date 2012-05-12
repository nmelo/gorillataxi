//
//  FeedbackTableItem.h
//  Frankly
//
//  Created by Nelson Melo on 4/27/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import <Three20/Three20.h>

#import "DBFeedback.h"

@interface FeedbackTableItem : TTTableTextItem { 

    DBFeedback* feedbackObject;
}

@property(nonatomic,retain) DBFeedback* feedbackObject;

+ (id)itemWithText:(NSString*)text URL:(NSString*)url feedback:(DBFeedback*)feedback;

@end  