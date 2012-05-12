//
//  FeedbackTableItem.m
//  Frankly
//
//  Created by Nelson Melo on 4/27/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#include "FeedbackTableItem.h"

@implementation FeedbackTableItem

@synthesize feedbackObject;

///////////////////////////////////////////////////////////////////////////////////////////////////
// class public

+ (id)itemWithText:(NSString*)text URL:(NSString*)url feedback:(DBFeedback*)feedback{
    FeedbackTableItem* item = [[[self alloc] init] autorelease];

    item.feedbackObject = feedback;
    item.text = text;
    item.URL = url;
    return item;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
	if ((self = [super init])) {
        //Any extra initialization?
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSCoding

- (id)initWithCoder:(NSCoder*)decoder {
	if ((self = [super initWithCoder:decoder])) {
        //Any extra initialization?
    }
	return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder {
	[super encodeWithCoder:encoder];
    

}

@end