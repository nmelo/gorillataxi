//
//  BrandProfileViewController.m
//  MobileFeedback
//
//  Created by Nelson Melo on 4/16/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import "CompanyController.h"

@implementation CompanyController

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithID:(NSString*)companyID {
    if ((self = [super init])) {
        
        _company = [[DBCompany objectWithPrimaryKeyValue:companyID] retain];
        
        self.title = _company.name;
        
        _resourcePath = RKMakePathWithObject(@"/companies/(company_id)/feedbacks", self._company);
        _resourceClass = [DBCompanyFeedback class];
    }
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController
- (void)loadView {
    [super loadView];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Profile", @"Feedback", nil]]; 
    [segmentedControl setFrame:CGRectMake(11, 20, 298, 40)];
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
    [self.view bringSubviewToFront:segmentedControl];
    
    UIImage * backgroundImage = [UIImage imageNamed:@"striped_back.jpg"];
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    self.tableView.backgroundColor = backgroundColor; 
    
    self.tableView.frame = CGRectMake(0, 70, 320, 300);
    
    profileView = [[UIView alloc] initWithFrame: CGRectMake(0, 70, 320, 300)];
    profileView.backgroundColor = backgroundColor;
    [self.view addSubview:profileView];
    [self.view bringSubviewToFront:profileView];
    sendTextField.hidden = YES;
    sendButton.hidden = YES;
    
    //Initialize UIControls
    companyImageView = [[TTImageView alloc] initWithFrame:CGRectMake(11, 18, 124, 112)];
    companyImageView.urlPath = [_company getImagePath];
    [profileView addSubview:companyImageView];

    companyNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(149, 0, 160, 51) ];
    companyNameLabel.text = self._company.name;
    companyNameLabel.backgroundColor = [UIColor clearColor];
    companyNameLabel.font = [UIFont boldSystemFontOfSize:17];
    [profileView addSubview:companyNameLabel];
     
    companyDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 120, 296, 130)];
    companyDescLabel.text = self._company.desc;
    companyDescLabel.numberOfLines = 4;
    companyNameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    companyDescLabel.backgroundColor = [UIColor clearColor];
    [profileView addSubview:companyDescLabel];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void)segmentAction:(id)sender
{
    if([sender selectedSegmentIndex] == 0) {
        [self.view bringSubviewToFront:profileView];
        sendTextField.hidden = YES;
        sendButton.hidden = YES;
    }
    else {
        [self.view bringSubviewToFront:self.tableView];
        sendTextField.hidden = NO;
        sendButton.hidden = NO;
    }
}

-(void) sendButtonWasClicked:(id)sender {
    super.feedbackable_id = _company.company_id;
    [super sendButtonWasClicked:sender];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc
{
    [super dealloc];
}

@end

