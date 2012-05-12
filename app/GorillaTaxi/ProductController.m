#import "ProductController.h"

@implementation ProductController
 
@synthesize productName, modelName, productImage;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithID:(NSString*) productID {
    if ((self = [super init])) {
        
        _product = [[DBProduct objectWithPrimaryKeyValue:productID] retain];
        _company = [[DBCompany objectWithPrimaryKeyValue:_product.company_id] retain];
        _user = [DBUser currentUser];
        
        self.title = _company.name;
        
        _resourcePath = RKMakePathWithObject(@"/products/(product_id)/feedbacks", self._product);
        _resourceClass = [DBProductFeedback class];
	}
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//UIView
- (void)loadView {
    [super loadView];

    productName.text = _product.name;
    
    productImage = [[TTImageView alloc] initWithFrame:CGRectMake(17, 11, 132, 115)];

    productImage.urlPath = [_product getImagePath];
    [self.view addSubview:productImage];
    
    productName = [[UILabel alloc] initWithFrame:CGRectMake(165, 28,145, 30)];
    productName.text = _company.name;
    productName.font = [UIFont boldSystemFontOfSize:17];
    productName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:productName];
    
    modelName = [[UILabel alloc] initWithFrame:CGRectMake(165,57,145,30)];
    modelName.text = _product.name;
    modelName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:modelName];
    
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//IBActions
-(void) sendButtonWasClicked:(id)sender {
    super.feedbackable_id = _product.product_id;
    [super sendButtonWasClicked:sender];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//NSObject
- (void)dealloc{
    [super dealloc];
}

@end
