#import "ProductController.h"

@implementation ProductController
 
@synthesize productName, modelName;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
//UIView
- (void)loadView {
    [super loadView];

//    productName.text = _product.name;
//    
//    productImage = [[TTImageView alloc] initWithFrame:CGRectMake(17, 11, 132, 115)];
//
//    productImage.urlPath = [_product getImagePath];
//    [self.view addSubview:productImage];
//    
    productName = [[UILabel alloc] initWithFrame:CGRectMake(165, 28,145, 30)];
//    productName.text = _company.name;
    productName.text = @"AA";
    productName.font = [UIFont boldSystemFontOfSize:17];
    productName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:productName];
    
    modelName = [[UILabel alloc] initWithFrame:CGRectMake(165,57,145,30)];
//    modelName.text = _product.name;
    modelName.text = @"AA";
    modelName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:modelName];
    
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
