#import "HomeController.h"

//This is the popularity algorithm we are going to use. Taken from stackoverflow. 
//http://meta.stackoverflow.com/questions/11602/what-formula-should-be-used-to-determine-hot-questions
/*
 Iviews = Views of the item
 Iscore = Upvotes on the item - Downvotes on the item
 Fscore = Upvotes on the feedback - Downvotes on the feedback
 Iage   = Days the item has been on the system
 Iupdated = When was a new item of the same type last posted.  
 
 (log(Iviews)*4) + ((Ifeedbacks * Iscore)/5) + sum(Fscore)
 --------------------------------------------------------
 ((Iage+1) - ((Iage - Iupdated)/2)) ^ 1.5
 */

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
    
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    self.tableView.frame = CGRectMake(0, segmentedControl.bottom + 10, applicationFrame.size.width, applicationFrame.size.height - 60);
    self.tableView.rowHeight = 70;
    
    // Setup the Table Header
    UIImage* logo = [UIImage imageNamed:@"logo2.png"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(120, 6, 100, 38)];
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
