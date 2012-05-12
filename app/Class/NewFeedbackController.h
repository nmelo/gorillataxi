//
//  NewVentViewController.h
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

#import "ImageDownloader.h"
#import "DBProductFeedback.h"
#import "DBProduct.h"

@interface NewFeedbackController : TTViewController <UIImagePickerControllerDelegate> {
	BOOL			hasImage;
	ImageDownloader	*imageDownloader;
	
	UIImage			*image;
    UIButton        *cameraButton;
	TTImageView		*imageView;
	UISwitch		*ownSwitch;
    
    DBProductFeedback *_feedback;
    DBProduct * _product; 
}

- (IBAction)continueButtonClicked;
- (IBAction)setImageClicked;
@end
