//
//  BrandProfileViewController.h
//  MobileFeedback
//
//  Created by Nelson Melo on 4/16/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import "FeedbackableController.h"

@interface CompanyController: FeedbackableController {

    UISegmentedControl *segmentedControl; 
    UIView *profileView;
    
    UILabel *companyDescLabel;
    UILabel *companyNameLabel;
    TTImageView *companyImageView;
        
}

- (void)segmentAction:(id)sender;

@end
