#import "HomeController.h"

@implementation HomeController

@synthesize  _resourcePath, _resourceClass;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
	if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
        
        UIImage* image = [UIImage imageNamed:@"home.png"];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Home" image:image tag:0] autorelease];
               
        _resourcePath = [@"/products" retain];
        _resourceClass = [DBProduct class];
	}
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//TTTableViewController
- (void)createModel {
    
    self.model = [[[RKRequestTTModel alloc] initWithResourcePath:_resourcePath params:nil objectClass:_resourceClass] autorelease];
    
}
- (void)didLoadModel:(BOOL)firstTime {
	[super didLoadModel:firstTime];
    
    if ([self.model isKindOfClass:[RKRequestTTModel class]]) {
		RKRequestTTModel* model = (RKRequestTTModel*)self.model;
        NSMutableArray* productItems = [NSMutableArray arrayWithCapacity:[model.objects count]];
        
        for (DBProduct* _product in model.objects) {
			NSString* URL = RKMakePathWithObject(@"db://product/(product_id)", _product);
			TTTableImageItem * item = [TTTableImageItem itemWithText:_product.name
                                    imageURL:[_product getImagePath]
                                    URL:URL];
            item.imageStyle = [TTImageStyle styleWithImage:nil defaultImage:nil contentMode:UIViewContentModeScaleAspectFill
                                                      size:CGSizeMake(60.f, 60.f)
                                                      next:nil];
			[productItems addObject:item];
		}
        
		TTListDataSource* dataSource = [TTListDataSource dataSourceWithItems:productItems];
		dataSource.model = model;
		self.dataSource = dataSource;
        
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//UIViewController
- (void)loadView {
    [super loadView];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"My items", @"Popular", nil]]; 
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.frame = CGRectMake(70, 8, segmentedControl.width + 50 , segmentedControl.height);
    [self.view addSubview:segmentedControl];

    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    self.tableView.frame = CGRectMake(0, segmentedControl.bottom + 10, applicationFrame.size.width, applicationFrame.size.height - 60);
    self.tableView.rowHeight = 70;
    
    // Setup the Table Header
    UIImage* logo = [UIImage imageNamed:@"frankly_logo.png"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(120, 6, logo.size.width, logo.size.height)];
	[headerBackgroundImage setImage:logo];
    
    self.navigationItem.titleView = headerBackgroundImage;
    self.navigationBarTintColor = [UIColor blackColor]; 

    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void)segmentAction:(id)sender
{
    if([sender selectedSegmentIndex] == 0) {

    }
    else {

    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTabDelegate
- (void)tabBar:(TTTabBar*)tabBar tabSelected:(NSInteger)selectedIndex 
{ 
    
} 
- (id<TTTableViewDataSource>)getDataSourceWithIndex:(NSInteger) selectedIndex { 
        
    TTTableViewDataSource *dSource = nil; 
    
    switch (selectedIndex) {
        case 0:
            dSource = [TTListDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:@"Adidas XP1" URL:@"db://feedback/1"],
                       [TTTableTextItem itemWithText:@"Sony PlayStation 3" URL:@"db://feedback/2"],
                       nil];
            break;
        case 1:
            dSource = [TTListDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:@"Call of Duty" URL:@"db://feedback/1"],
                       [TTTableTextItem itemWithText:@"Nike Kobe" URL:@"db://feedback/2"],
                       nil];
            break;
        case 2:
            dSource = [TTListDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:@"Canon 7D" URL:@"tt://feedback/1"],
                       [TTTableTextItem itemWithText:@"Amazon Kindle" URL:@"db://feedback/2"],
                       nil];
            break; 
        default:
            dSource = nil;
            break;
    }
    return dSource;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
}


@end
