#import "ProductController.h"

@implementation ProductController
 
@synthesize productName, modelName, address, price, prices, letsGoButton, getAride;


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//UIViewController
- (void)loadView {
    [super loadView];
    self.navigationController.navigationBar.hidden = YES;
        
    UIImage* backgroundImage = [UIImage imageNamed:@"background_screen3.png"];
	UIImageView* background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	[background setImage:backgroundImage];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];

    UIImage* header = [UIImage imageNamed:@"header.png"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
	[headerBackgroundImage setImage:header];
    [self.view addSubview:headerBackgroundImage];
    
    UIImage* getarideImage = [UIImage imageNamed:@"getaride.png"];
    UIImageView* getaride = [[UIImageView alloc] initWithFrame:CGRectMake(100, 90,117, 19)];
	[getaride setImage:getarideImage];
    [self.view addSubview:getaride];
    
    UIImage* enteryourImage = [UIImage imageNamed:@"enteryour.png"];
    UIImageView* enteryour = [[UIImageView alloc] initWithFrame:CGRectMake(20, 148,188, 15)];
	[enteryour setImage:enteryourImage];
    [self.view addSubview:enteryour];
    
    UIImage* willingtopayImage = [UIImage imageNamed:@"willingtopay.png"];
    UIImageView* willingtopay = [[UIImageView alloc] initWithFrame:CGRectMake(20, 228,219, 15)];
	[willingtopay setImage:willingtopayImage];
    [self.view addSubview:willingtopay];

    UIImage* faceImage = [UIImage imageNamed:@"face.png"];
    UIImageView* face = [[UIImageView alloc] initWithFrame:CGRectMake(140, 320,33, 54)];
	[face setImage:faceImage];
    [self.view addSubview:face];
    
    address = [[UITextView alloc] initWithFrame:CGRectMake(20, 170, 250, 35)];
    address.backgroundColor = [UIColor clearColor];
     UIImageView *imgView = [[UIImageView alloc]initWithFrame: address.bounds];
    [address setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    imgView.image = [UIImage imageNamed: @"textview1.png"];
    [address addSubview: imgView];
    [address sendSubviewToBack: imgView];
    [self.view addSubview:address]; 
    
    price = [[UITextView alloc] initWithFrame:CGRectMake(20, 250, 110, 35)];
    price.backgroundColor = [UIColor clearColor];
    imgView = [[UIImageView alloc]initWithFrame: price.bounds];
    [price setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    imgView.image = [UIImage imageNamed: @"textview2.png"];
    [price addSubview: imgView];
    [price sendSubviewToBack: imgView];

    [self.view addSubview:price]; 
    
    UIImage* drive_image = [UIImage imageNamed:@"letsroll.png"];
    self.letsGoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.letsGoButton.frame = CGRectMake(60, 390, 203, 48);
    [self.letsGoButton setBackgroundImage:drive_image forState:UIControlStateNormal];
    [self.letsGoButton  addTarget:self action:@selector(letsGo_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:letsGoButton];

    
}


- (void)viewWillAppear:(BOOL)animated {  
         
}
    
- (void)letsGo_OnClick
{
    TTOpenURL(@"db://newProduct");
}



//PickerViewController.m
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

//PickerViewController.m
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [prices count];
}

//PickerViewController.m
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [prices objectAtIndex:row];
}

//PickerViewController.m
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"Selected Color: %@. Index of selected color: %i", [prices objectAtIndex:row], row);
}
    
///////////////////////////////////////////////////////////////////////////////////////////////////
//IBActions
-(void) sendButtonWasClicked:(id)sender {
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//NSObject
- (void)dealloc{
    [super dealloc];
}

@end
