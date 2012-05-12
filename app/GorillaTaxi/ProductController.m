#import "ProductController.h"

@implementation ProductController
 
@synthesize productName, modelName, address, price, prices, letsGoButton;

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
    
    prices = [[NSMutableArray alloc] init];
    [prices addObject:@"$5.00"];
    [prices addObject:@"$10.00"];
    [prices addObject:@"$15.00"];
    [prices addObject:@"$20.00"];
    [prices addObject:@"$25.00"];
    [prices addObject:@"$30.00"];
    [prices addObject:@"$35.00"];
    
    UIImage* background = [UIImage imageNamed:@"background.jpg"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	[headerBackgroundImage setImage:background];
    [self.view addSubview:headerBackgroundImage];
    [self.view sendSubviewToBack:headerBackgroundImage];
    
    productName = [[UILabel alloc] initWithFrame:CGRectMake(20, 28,145, 30)];
    productName.text = @"I'm going to:";
    productName.font = [UIFont boldSystemFontOfSize:17];
    productName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:productName];
    
    address = [[UITextView alloc] initWithFrame:CGRectMake(20, 60, 250, 40)];
    [self.view addSubview:address]; 
    
    modelName = [[UILabel alloc] initWithFrame:CGRectMake(20, 130,145,30)];
    modelName.text = @"Willing to pay:";
    modelName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:modelName];

    price = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 170, 250, 200)];
    [price setDelegate:self];
    [self.view addSubview:price]; 
    
    UIImage* drive_image = [UIImage imageNamed:@"letsgo.png"];
    self.letsGoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.letsGoButton.frame = CGRectMake(20, 360, 133, 38);
    [self.letsGoButton setBackgroundImage:drive_image forState:UIControlStateNormal];
    [self.letsGoButton  addTarget:self action:@selector(letsGo_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:letsGoButton];

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
