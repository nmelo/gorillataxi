//
//  NewVentViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/17/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "NewFeedbackController.h"
#import "FeedbackTypeController.h"

@implementation NewFeedbackController

///////////////////////////////////////////////////////////////////////////////////////////////////
// Init
- (id)initWithProdID:(NSString*)product_id {
	if ((self = [super init])) {
         
        _product = [[DBProduct objectWithPrimaryKeyValue:product_id] retain];
        _feedback = [[DBProductFeedback object] retain];
        _feedback.product_id = _product.product_id;
        
        self.hidesBottomBarWhenPushed = YES;   
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (void)loadView {
    [super loadView];
    
    self.navigationBarTintColor = [UIColor blackColor]; 
    
    self.title = @"Product";
    
    UIImage * backgroundImage = [UIImage imageNamed:@"striped_back.jpg"];
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    self.view.backgroundColor = backgroundColor; 
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    window.backgroundColor = backgroundColor;
        
    cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.frame = CGRectMake(30, 17, 260, 208);
    [cameraButton setImage:[UIImage imageNamed:@"upload_photo.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:cameraButton];    
    
    [cameraButton addTarget:self action:@selector(setImageClicked) 
             forControlEvents:UIControlEventTouchUpInside];

    UILabel *iOwn = [[UILabel alloc] initWithFrame:CGRectMake(55, 285, 112, 21)];
    iOwn.text = @"I own this item";
    iOwn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:iOwn];
    
    ownSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(175, 280, 94, 27)];
    ownSwitch.backgroundColor = [UIColor clearColor];
    [ownSwitch setOn:TRUE animated:TRUE];
    [self.view addSubview:ownSwitch];
    
    UIButton *continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    continueButton.frame = CGRectMake(10, 343, 302, 43);
    [continueButton setImage:[UIImage imageNamed:@"continue.png"] forState:UIControlStateNormal];
    [continueButton addTarget:self action:@selector(continueButtonClicked) 
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:continueButton];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (IBAction)continueButtonClicked {
		
    NSString *URL = RKMakePathWithObject(@"db://feedbackType/(feedback_id)", _feedback);
    TTOpenURL(URL);
}
- (IBAction)setImageClicked {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
	picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;//UIImagePickerControllerSourceTypeCamera;
	[self presentModalViewController:picker animated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	
	UIImage	*tempImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	image = tempImage;
	hasImage = TRUE;
    [cameraButton setImage:image forState:UIControlStateNormal];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSobject
- (void)dealloc {
	[imageDownloader release];
	[image release];
	[imageView release];
	[ownSwitch release];
	
    [super dealloc];
}

@end
