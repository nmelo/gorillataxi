//
//  NewProductViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "NewProductController.h"
#import "NewFeedbackController.h"
#import "JSONHelper.h"
#import "QSStrings.h"

@implementation NewProductController

@synthesize imageButton, brandField, productField, upcField, colorField;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
	if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        
        self.hidesBottomBarWhenPushed = YES;  
        self.title = @"Login";
		self.autoresizesForKeyboard = YES;
    }
    return self;
}

- (void)loadView {
	[super loadView];
    
    hasPhoto = FALSE;
	self.title = @"New Product";
    
    self.navigationBarTintColor = [UIColor blackColor]; 
    
    UIImage * backgroundImage = [UIImage imageNamed:@"striped_back.jpg"];
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    self.view.backgroundColor = backgroundColor; 
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = backgroundColor;
    
    UIImage *backImage = [UIImage imageNamed:@"upload_photo.jpg"];
    imageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 260, 208)];
    [imageButton setImage:backImage forState:UIControlStateNormal];
    [self.view addSubview:imageButton];
        
    brandField = [[UITextField alloc] initWithFrame:CGRectZero];
    brandField.placeholder = @"Type the brand of the product...";
	brandField.delegate = self;
    brandField.returnKeyType = UIReturnKeyNext;
    
    productField = [[UITextField alloc] initWithFrame:CGRectZero];
    productField.placeholder = @"Type the name of the product...";
	productField.delegate = self;
    productField.returnKeyType = UIReturnKeyNext;
    
    upcField = [[UITextField alloc] initWithFrame:CGRectZero];
    upcField.placeholder = @"Type the upc code of the product...";
	upcField.delegate = self;
    upcField.returnKeyType = UIReturnKeyNext;
    
    colorField = [[UITextField alloc] initWithFrame:CGRectZero];
    colorField.placeholder = @"Type the color of the product...";
	colorField.delegate = self;
    colorField.returnKeyType = UIReturnKeyGo;
    
    //Initialize navigation. 
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
											  target:self action:@selector(doneButtonClicked)];
    
    [imageButton addTarget:self action:@selector(addPhotoClicked) 
          forControlEvents:UIControlEventTouchUpInside];
    
	self.navigationItem.rightBarButtonItem.enabled = YES;

}

- (void)createModel {
	NSMutableArray* items = [NSMutableArray array];
	[items addObject:[TTTableControlItem itemWithCaption:@"Brand" control:brandField]];
	[items addObject:[TTTableControlItem itemWithCaption:@"Product" control:productField]];
	[items addObject:[TTTableControlItem itemWithCaption:@"UPC Code" control:upcField]];
	[items addObject:[TTTableControlItem itemWithCaption:@"Color" control:colorField]];

	self.dataSource = [TTListDataSource dataSourceWithItems:items];
    
	[brandField becomeFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void)doneButtonClicked {
	// check if company exists
	NSString *companyId = [JSONHelper getCompanyId:brandField.text];

	if (companyId == nil) {
		NSDictionary *companyValues = [NSDictionary dictionaryWithObjectsAndKeys:
									brandField.text, @"name",
									@"", @"description",
									nil];
		
		companyId = [JSONHelper addCompany:companyValues];
	}
	
	NSString *fileName = [NSString stringWithFormat:@"%@.jpg", productField.text];
	NSData *imageData = UIImageJPEGRepresentation(imageButton.imageView.image, 1.0);
	NSString *encodedString = [QSStrings encodeBase64WithData:imageData];
	
	NSDictionary *productValues = [NSDictionary dictionaryWithObjectsAndKeys:
								   productField.text, @"name",
								   @"", @"description",
								   companyId, @"company_id",
								   upcField.text, @"upc",
								   colorField.text, @"color",
								   @"image/jpeg", @"content_type",
								   fileName, @"filename",
								   encodedString, @"binary_data_base64",
								   nil];
	
	NSString *productId = [JSONHelper addProduct:productValues];
    //newViewPage.image = imageButton.imageView.image;
    
	TTOpenURL([NSString stringWithFormat:@"db://newFeedback/%i", productId]);
}
- (void)addPhotoClicked {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;

	picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	[self presentModalViewController:picker animated:YES];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	
	UIImage	*image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	
	[imageButton setImage:image forState:UIControlStateNormal];
	hasPhoto = TRUE;
	
	if (hasPhoto && [self.brandField.text length] > 0 && [self.productField.text length] > 0) {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	} else {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
	CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
	CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];

	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
	CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0) {
		heightFraction = 0.0;
	} else if (heightFraction > 1.0) {
		heightFraction = 1.0;
	}
	
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];

	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
		animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
	} else {
		animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
	}
	
	CGRect viewFrame = self.view.frame;

	viewFrame.origin.y -= animatedDistance;
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
	[self.view setFrame:viewFrame];
    
	[UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
	CGRect viewFrame = self.view.frame;

	viewFrame.origin.y += animatedDistance;
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
	[self.view setFrame:viewFrame];
    
	[UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	if (hasPhoto && [self.brandField.text length] > 0 && [self.productField.text length] > 0) {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	} else {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	}
	
	return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
}


@end
