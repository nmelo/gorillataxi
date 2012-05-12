//
//  CustomTableCellViewController.m
//  MobileFeedback
//
//  Created by Nelson Melo on 4/16/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import "FeedbackItemCell.h"

@implementation FeedbackItemCell

@synthesize authorLabel, goodNumberLabel, goodButton, badNumberLabel, badButton, feedbackTypeImageView, _newVote, feedbackObject, poster;

///////////////////////////////////////////////////////////////////////////////////////////////////
//UITableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ((self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier])) {
                
        _item = nil;

        [self.contentView addSubview:authorLabel];
        
        authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(7,46,159,21)];
        [self.contentView addSubview:authorLabel];
        
        goodNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(208,45,30,21)];
        [self.contentView addSubview:goodNumberLabel];
        
        goodButton = [UIButton buttonWithType:UIButtonTypeCustom];
        goodButton.frame = CGRectMake(175,37,22,26);
        [self.contentView addSubview:goodButton];
        
        badNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(278,45,30,21)];
        [self.contentView addSubview:badNumberLabel];
        
        badButton = [UIButton buttonWithType:UIButtonTypeCustom];
        badButton.frame = CGRectMake(245,37,22,26);
        [self.contentView addSubview:badButton];
        
        feedbackTypeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(286,10,25,25)];
        [self.contentView addSubview:feedbackTypeImageView];

    }
    return self;
}   

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)layoutSubviews {
	[super layoutSubviews];

    [self setAccessoryType:UITableViewCellAccessoryNone];

    self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17];   
    self.textLabel.frame = CGRectMake(7,10,281,21);
    self.textLabel.textColor = [UIColor blackColor];
    
    authorLabel.backgroundColor = [UIColor clearColor];
    authorLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    authorLabel.text = poster.first_name;;
    
    goodNumberLabel.backgroundColor = [UIColor clearColor];
    goodNumberLabel.text = [NSString stringWithFormat:@"%i", arc4random() % 20];
    badNumberLabel.backgroundColor = [UIColor clearColor];
    badNumberLabel.text = [NSString stringWithFormat:@"%i", arc4random() % 20];
    
    UIImage *goodImg = [UIImage  imageNamed:@"thumbs_up.png"];
    UIImage *goodImg2 = [UIImage  imageNamed:@"thumbs_up.png"];
    [goodButton setImage:goodImg forState:UIControlStateNormal];
    [goodButton setImage:goodImg2 forState:UIControlStateSelected];
    [goodButton setImage:goodImg2 forState:UIControlStateHighlighted];
    [goodButton setImage:goodImg2 forState:(UIControlStateHighlighted+UIControlStateSelected)];
    [goodButton addTarget:self action:@selector(goodButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *badImg = [UIImage  imageNamed:@"thumbs_down.png"];
    UIImage *badImg2 = [UIImage  imageNamed:@"thumbs_down.png"];
    [badButton setImage:badImg forState:UIControlStateNormal];
    [badButton setImage:badImg2 forState:UIControlStateSelected];
    [badButton setImage:badImg2 forState:UIControlStateHighlighted];
    [badButton setImage:badImg2 forState:(UIControlStateHighlighted+UIControlStateSelected)];
    [badButton addTarget:self action:@selector(badButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    int type = [(NSNumber*)((FeedbackTableItem*) _item).feedbackObject.feedback_type intValue];
    
    if(type == 1)
    {
        feedbackTypeImageView.image = [UIImage imageNamed:@"innovation_selected.png"];
    }
    else if (type == 2)
    {
        feedbackTypeImageView.image = [UIImage imageNamed:@"comment_selected.png"];
    }
    else if(type == 3)
    {
        feedbackTypeImageView.image = [UIImage imageNamed:@"problem_selected.png"];   
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
-(void) goodButtonWasClicked:(id)sender {
    
    //Create a new positive Vote and send it. 
    _newVote = [[DBVote object] retain];
    _newVote.feedback_id = ((FeedbackTableItem*) _item).feedbackObject.feedback_id;
    _newVote.user_id = [NSNumber numberWithInt:15];
    _newVote.didLike = [NSNumber numberWithInt:1];

	[[RKObjectManager sharedManager] postObject:_newVote delegate:self];    
}

-(void) badButtonWasClicked:(id)sender {
    
    //Create a new negative Vote and send it. 
    _newVote = [[DBVote object] retain];
    _newVote.feedback_id = ((FeedbackTableItem*) _item).feedbackObject.feedback_id;
    _newVote.user_id = [NSNumber numberWithInt:15];
    _newVote.didLike = [NSNumber numberWithInt:0];
    
	[[RKObjectManager sharedManager] postObject:_newVote delegate:self];    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//RKObjectLoaderDelegate
- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	
    //If we are coming from a new feedback posted. 
    if(_newVote != nil) {
        
        //Show the alert notifiying feedback was posted. 
        [[[[UIAlertView alloc] initWithTitle:@"Thanks" 
                                     message:@"Your vote was posted."
                                    delegate:nil 
                           cancelButtonTitle:@"OK" 
                           otherButtonTitles:nil] autorelease] show];
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
// TTTableViewCell

- (id)object {
	return _item;
}

- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		_item = object;
        self.textLabel.text = ((FeedbackTableItem*) _item).feedbackObject.content;    
        feedbackObject = ((FeedbackTableItem*)_item).feedbackObject;
        poster = [DBUser objectWithPrimaryKeyValue:feedbackObject.user_id];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//NSObject
- (void)dealloc {
    [super dealloc];
}

@end
