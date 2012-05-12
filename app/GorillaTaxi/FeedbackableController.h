//
//  FeedbackableController.h
//  Frankly
//
//  Created by Nelson Melo on 4/29/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>

#import <RestKit/ObjectMapping/RKRailsRouter.h>

#import "FeedbackDataSource.h"
#import "FeedbackTableItem.h"
#import "FeedbackItemCell.h"

#import "DBProduct.h"
#import "DBCompany.h"
#import "DBCompanyFeedback.h"
#import "DBProductFeedback.h"
#import "DBUser.h"

@interface FeedbackableController : TTTableViewController<UITextFieldDelegate, RKObjectLoaderDelegate, FeedbackItemCellDelegate> {
    
    UITextField *sendTextField;
    UIButton *sendButton;
    UIButton *ideaButton;
    UIButton *commentButton;
    UIButton *negativeButton;
    
    NSMutableArray *_feedbackItems;

    NSString* _resourcePath;
	Class _resourceClass;
    
    NSNumber *feedbackable_id;
    
    DBProduct *_product; 
    DBCompany *_company; 
    DBFeedback *_newFeedback;
    DBUser  *_user; 
}


@property(nonatomic, retain) UITextField *sendTextField;
@property(nonatomic, retain) UIButton *sendButton;
@property(nonatomic, retain) UIButton *ideaButton;
@property(nonatomic, retain) UIButton *commentButton;
@property(nonatomic, retain) UIButton *negativeButton;
@property(nonatomic, retain) DBProduct *_product; 
@property(nonatomic, retain) DBCompany *_company; 
@property(nonatomic, retain) DBFeedback *_newFeedback;

@property (nonatomic, retain) NSMutableArray *_feedbackItems;
@property (nonatomic, retain) NSNumber *feedbackable_id;

@property (nonatomic, retain) NSString* _resourcePath;
@property (nonatomic, retain) Class _resourceClass;

-(void) sendButtonWasClicked:(id)sender;

@end

#import "ProductController.h"
#import "CompanyController.h"
