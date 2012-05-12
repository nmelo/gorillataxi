//
//  NewProductViewController.h
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>

@interface NewProductController : TTTableViewController <UIImagePickerControllerDelegate, UITextFieldDelegate> 
{
	CGFloat animatedDistance;
	BOOL	hasPhoto;
	
	UIButton		*imageButton;
	UITextField		*brandField;
	UITextField		*productField;
	UITextField		*upcField;
	UITextField		*colorField;
}

@property (nonatomic, retain) UIButton *imageButton;
@property (nonatomic, retain) UITextField *brandField;
@property (nonatomic, retain) UITextField *productField;
@property (nonatomic, retain) UITextField *upcField;
@property (nonatomic, retain) UITextField *colorField;

- (void)doneButtonClicked;
- (void)addPhotoClicked;


@end
