//
//  CustomTableCellViewController.h
//  MobileFeedback
//
//  Created by Nelson Melo on 4/16/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import "FeedbackTableItem.h"
#import "DBVote.h"
#import "DBFeedback.h"
#import "DBUser.h"

@interface FeedbackItemCell : TTTableTextItemCell<RKObjectLoaderDelegate> {
    
    UILabel* authorLabel; 
    UILabel* goodNumberLabel;
    UIButton* goodButton; 
    UILabel *badNumberLabel; 
    UIButton *badButton; 
    UIImageView * feedbackTypeImageView;
    
    DBVote *_newVote;
    DBFeedback* feedbackObject;
    DBUser* poster;
}

@property(nonatomic, retain) UILabel* authorLabel; 
@property(nonatomic, retain) UILabel* goodNumberLabel;
@property(nonatomic, retain) UIButton* goodButton; 
@property(nonatomic, retain) UILabel *badNumberLabel; 
@property(nonatomic, retain) UIButton *badButton; 
@property(nonatomic, retain) UIImageView * feedbackTypeImageView;

@property(nonatomic, retain) DBVote *_newVote;
@property(nonatomic, retain) DBFeedback* feedbackObject;
@property(nonatomic, retain) DBUser* poster;

@end