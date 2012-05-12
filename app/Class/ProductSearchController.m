//
//  BrandSearchViewController.m
//  MobileFeedback
//
//  Created by Nelson Melo on 4/16/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import "ProductSearchController.h"

@implementation ProductSearchController

@synthesize _resourcePath, _resourceClass, savedSearchTerm, savedScopeButtonIndex, searchDisplayController;


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
	if ((self = [super initWithNavigatorURL:URL query:query])) {
        
        self.title = @"Search";
        
        UIImage* image = [UIImage imageNamed:@"new.png"];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"New" image:image tag:0] autorelease];
        
        _resourcePath = [@"/products" retain];
		_resourceClass = [DBProduct class];
    }
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//TTTableViewController
//The RKRequestTTModel for this controller is created here. This one will be used to populate all the fields. 
- (void)createModel {
    
    //Initialize the model. Gets my data from the JSON service and stores it in the DB. 
    self.model = [[[RKRequestTTModel alloc] initWithResourcePath:_resourcePath params:nil objectClass:_resourceClass] autorelease];
    
}
- (void)didLoadModel:(BOOL)firstTime {
    [super didLoadModel:firstTime];
    
    if ([self.model isKindOfClass:[RKRequestTTModel class]]) {
		RKRequestTTModel* model = (RKRequestTTModel*)self.model;
        NSMutableArray* companyItems = [NSMutableArray arrayWithCapacity:[model.objects count]];
        
        for (DBProduct* product in model.objects) {
			NSString* URL = RKMakePathWithObject(@"db://newFeedback/(product_id)", product);
			TTTableImageItem* item = [TTTableImageItem itemWithText:product.name imageURL:[product getImagePath] URL:URL];
            item.imageStyle = [TTImageStyle styleWithImage:nil defaultImage:nil contentMode:UIViewContentModeScaleAspectFill
                                                      size:CGSizeMake(60.f, 60.f)
                                                      next:nil];
			[companyItems addObject:item];
		}
        
		ProductSearchDataSource* dataSource = (ProductSearchDataSource*)[ProductSearchDataSource dataSourceWithItems:companyItems];
		dataSource.model = model;
		self.dataSource = dataSource;
        
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void) plusButtonClicked {
    TTOpenURL(@"db://newProduct");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarTintColor = [UIColor blackColor]; 
    self.tableView.rowHeight = 70;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] 
											  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
											  target:self action:@selector(plusButtonClicked)];
    
    //Initialize the search bar, setup normal and filtered list. 
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, TTApplicationFrame().size.width, 0)];
    searchBar.tintColor = [UIColor blackColor];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search for products";
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    [searchBar release];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    [searchDisplayController setDelegate:self];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////
// UISearchDisplayController Delegate Methods
- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    ProductSearchDataSource *ds = self.dataSource;
    [searchDisplayController setSearchResultsDataSource:self.dataSource];
    [ds initializeFilteredContent];
    ds.searchActive = YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
    ProductSearchDataSource *ds = self.dataSource;
    [ds filterContentForSearchText:searchText scope:scope];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    ProductSearchDataSource *ds = self.dataSource;
    ds.searchActive = NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////
//NSObject
- (void)dealloc {
	[super dealloc];
}

@end
