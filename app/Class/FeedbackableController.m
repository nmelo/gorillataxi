//
//  FeedbackableController.m
//  Frankly
//
//  Created by Nelson Melo on 4/29/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import "FeedbackableController.h"


@implementation FeedbackableController

@synthesize sendTextField, sendButton, ideaButton, 
commentButton, negativeButton, _product, _feedbackItems, _resourcePath, _resourceClass, _company, _newFeedback, feedbackable_id;


///////////////////////////////////////////////////////////////////////////////////////////////////
//Init
- (id)init {
    if ((self = [super initWithStyle:UITableViewStylePlain])) {
        
        self.hidesBottomBarWhenPushed = YES;   

    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//TTTableViewController
- (void)createModel {
    
    self.model = [[[RKRequestTTModel alloc] initWithResourcePath:_resourcePath params:nil objectClass:_resourceClass] autorelease];
    
}
- (void)didLoadModel:(BOOL)firstTime {
	[super didLoadModel:firstTime];
    
    if ([self.model isKindOfClass:[RKRequestTTModel class]]) {
		RKRequestTTModel* model = (RKRequestTTModel*)self.model;
        NSMutableArray* feedbackItems = [NSMutableArray arrayWithCapacity:[model.objects count]];
        
        for (DBFeedback* _feedback in model.objects) {
			FeedbackTableItem* item = [FeedbackTableItem itemWithText:_feedback.content
                                                                  URL:@"" feedback:_feedback];
            item.URL = nil;
			[feedbackItems addObject:item];
		}
        
		FeedbackDataSource* dataSource = (FeedbackDataSource*)[FeedbackDataSource dataSourceWithItems:feedbackItems];
		dataSource.model = model;
		self.dataSource = dataSource;
        
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//UIView
- (void)loadView {
    [super loadView];
    
    // Background styling
	UIImageView* backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"striped_back.jpg"]];
	[self.navigationController.view addSubview:backgroundImage];
	[self.navigationController.view sendSubviewToBack:backgroundImage];
	[backgroundImage release];
	
    self.navigationBarTintColor = [UIColor blackColor]; 
    
	self.view.backgroundColor = [UIColor clearColor];
	self.tableView.backgroundColor = [UIColor clearColor];
    
    //Adjust tableView to fit a narrower space. 
    self.tableView.frame = CGRectMake(0, 134, 320, 230);
    self.tableView.rowHeight = 76;
    
    sendTextField = [[UITextField  alloc] initWithFrame:CGRectMake(8, 376, 224, 31)];
	sendTextField.font = [UIFont systemFontOfSize:12];
	sendTextField.delegate = self;
    sendTextField.returnKeyType = UIReturnKeyDone;
    sendTextField.borderStyle = UITextBorderStyleRoundedRect;
    sendTextField.enablesReturnKeyAutomatically = TRUE;
    [self.view addSubview:sendTextField];
    
    
    UIImage *ideaImg1 = [UIImage  imageNamed:@"innovation_default.png"];
    UIImage *ideaImg2 = [UIImage  imageNamed:@"innovation_selected.png"];    
    ideaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ideaButton.frame = CGRectMake(259, 378, 30, 30);    
    [ideaButton setImage:ideaImg1 forState:UIControlStateNormal];
    [ideaButton setImage:ideaImg2 forState:UIControlStateSelected];
    [ideaButton setImage:ideaImg2 forState:UIControlStateHighlighted];
    [ideaButton setImage:ideaImg2 forState:(UIControlStateHighlighted+UIControlStateSelected)];
    [self.view addSubview:ideaButton];
    
    [ideaButton addTarget:self action:@selector(ideaButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [ideaImg1 release];
    [ideaImg2 release];
    
    UIImage *negativeImg1 = [UIImage  imageNamed:@"problem_default.png"];
    UIImage *negativeImg2 = [UIImage  imageNamed:@"problem_selected.png"];    
    negativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [negativeButton setFrame:CGRectMake(244, 407, 30, 30)];    
    [negativeButton setImage:negativeImg1 forState:UIControlStateNormal];
    [negativeButton setImage:negativeImg2 forState:UIControlStateSelected];
    [negativeButton setImage:negativeImg2 forState:UIControlStateHighlighted];
    [negativeButton setImage:negativeImg2 forState:(UIControlStateHighlighted+UIControlStateSelected)];
    [self.view addSubview:negativeButton];
    
    [negativeButton addTarget:self action:@selector(negativeButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [negativeImg1 release];
    [negativeImg2 release];
    
    UIImage *commentImg1 = [UIImage  imageNamed:@"comment_default.png"];
    UIImage *commentImg2 = [UIImage  imageNamed:@"comment_selected.png"];    
    commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(274, 407, 30, 30);    
    [commentButton setImage:commentImg1 forState:UIControlStateNormal];
    [commentButton setImage:commentImg2 forState:UIControlStateSelected];
    [commentButton setImage:commentImg2 forState:UIControlStateHighlighted];
    [commentButton setImage:commentImg2 forState:(UIControlStateHighlighted+UIControlStateSelected)];
    [self.view addSubview:commentButton];
    [commentButton addTarget:self action:@selector(commentButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [commentImg1 release];
    [commentImg2 release];
    
    [ideaButton setHidden:YES];
    [negativeButton setHidden:YES];
    [commentButton setHidden:YES];
    
    //Selected is the default state of the idea button. 
    ideaButton.selected = YES;
    
    sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendButton setImage:[UIImage imageNamed:@"send.png"] forState:UIControlStateNormal];
    sendButton.frame = CGRectMake(238, 375, 72, 31);
    [sendButton addTarget:self action:@selector(sendButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//IBActions
-(void) ideaButtonWasClicked:(id)sender {
    ideaButton.selected = YES;
    negativeButton.selected = NO;
    commentButton.selected = NO;
}
-(void) negativeButtonWasClicked:(id)sender {
    ideaButton.selected = NO;
    negativeButton.selected = YES;
    commentButton.selected = NO;
}
-(void) commentButtonWasClicked:(id)sender {
    
    ideaButton.selected = NO;
    negativeButton.selected = NO;
    commentButton.selected = YES;
}
-(void) sendButtonWasClicked:(id)sender {
    
    [self.sendTextField resignFirstResponder];   
    
    //Creating a new Feedback object and sending to the server.
    if([self isKindOfClass:[CompanyController class]]) {
       
        _newFeedback = [[DBCompanyFeedback object] retain];
        _newFeedback.company_id = feedbackable_id;
    }
    else 
    {
        _newFeedback = [[DBProductFeedback object] retain];
        _newFeedback.product_id = feedbackable_id;    
    }
    
    _newFeedback.content = sendTextField.text;
    _newFeedback.user_id = [NSNumber numberWithInt:15];
    
    //Determine which type of feedback they are giving. 
    if(ideaButton.selected) { _newFeedback.feedback_type = [NSNumber numberWithInt:1];  }
    else if (negativeButton.selected) { _newFeedback.feedback_type = [NSNumber numberWithInt:3]; }
    else { _newFeedback.feedback_type = [NSNumber numberWithInt:2]; }

    _newFeedback.owned_by_me = [NSNumber numberWithInt:1]; 
    
	[[RKObjectManager sharedManager] postObject:_newFeedback delegate:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//TTTextEditorDelegate
- (void)textFieldDidBeginEditing:(UITextField*)textEditor {
    
    [ideaButton setHidden:NO];
    [negativeButton setHidden:NO];
    [commentButton setHidden:NO];
    
    int increment = 70;
    
    sendTextField.height = sendTextField.height + increment;
    sendButton.frame = CGRectMake(238, 443, 72, 34);
    self.view.height +=increment;
    
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, -285.0);
    [self.view setTransform:myTransform];
    
    CGAffineTransform myTableTransform = CGAffineTransformMakeTranslation(0.0, increment * -1);
    [self.tableView setTransform:myTableTransform];
    
    
}
- (void)textFieldDidEndEditing:(UITextField*)textEditor {
    
    [ideaButton setHidden:YES];
    [negativeButton setHidden:YES];
    [commentButton setHidden:YES];
    
    int increment = 70;
    
    sendTextField.height = 31;
    
    sendButton.frame = CGRectMake(238, 375, 72, 34);
    self.view.height -=increment;
    
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 0.0);
    [self.view setTransform:myTransform];
    [self.tableView setTransform:myTransform];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//RKObjectLoaderDelegate
- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
	
    //If we are coming from a new feedback posted. 
    if(_newFeedback != nil) {
        
        //Show the alert notifiying feedback was posted. 
        self.sendTextField.text = @"";
        [[[[UIAlertView alloc] initWithTitle:@"Thanks" 
                                     message:@"Your feedback was posted."
                                    delegate:nil 
                           cancelButtonTitle:@"OK" 
                           otherButtonTitles:nil] autorelease] show];
        
/*        //Add a new TableItem to the datasource. 
        NSString* URL = RKMakePathWithObject(@"db://feedback/(feedback_id)", _newFeedback);
        FeedbackTableItem* item = [FeedbackTableItem itemWithText:_newFeedback.content
                                                              URL:URL feedback:_newFeedback];
        [_feedbackItems addObject:item];
        self.dataSource = (FeedbackDataSource*)[FeedbackDataSource dataSourceWithItems:_feedbackItems];
        [self.tableView reloadData];
 */
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
//NSObject
- (void)dealloc{
    [super dealloc];
}


@end
