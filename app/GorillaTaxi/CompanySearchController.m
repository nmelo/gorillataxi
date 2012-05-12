//
//  BrandSearchViewController.m
//  MobileFeedback
//
//  Created by Nelson Melo on 4/16/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import "CompanySearchController.h"

@implementation CompanySearchController

@synthesize _resourcePath, _resourceClass, savedSearchTerm, savedScopeButtonIndex, searchDisplayController;


///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
	if ((self = [super initWithNavigatorURL:URL query:query])) {
        
        self.title = @"Brands";
        
        UIImage* image = [UIImage imageNamed:@"brands.png"];
        self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
        
        _resourcePath = [@"/companies" retain];
		_resourceClass = [DBCompany class];
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

        for (DBCompany* company in model.objects) {
			NSString* URL = RKMakePathWithObject(@"db://company/(company_id)", company);
			TTTableImageItem* item = [TTTableImageItem itemWithText:company.name imageURL:[company getImagePath] URL:URL];
            item.imageStyle = [TTImageStyle styleWithImage:nil defaultImage:nil contentMode:UIViewContentModeScaleAspectFill
                                                      size:CGSizeMake(60.f, 60.f)
                                                      next:nil];
			[companyItems addObject:item];
		}
        
		CompanySearchDataSource* dataSource = (CompanySearchDataSource*)[CompanySearchDataSource dataSourceWithItems:companyItems];
		dataSource.model = model;
		self.dataSource = dataSource;

    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//UIViewController
- (void)loadView {
    [super loadView];
    self.navigationBarTintColor = [UIColor blackColor]; 
    self.tableView.rowHeight = 70;
    
    //Initialize the search bar, setup normal and filtered list. 
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, TTApplicationFrame().size.width, 0)];
    searchBar.tintColor = [UIColor blackColor];
    searchBar.delegate = self;
    searchBar.placeholder = @"Search a brand";
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    [searchBar release];
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    [searchDisplayController setDelegate:self];

}


////////////////////////////////////////////////////////////////////////////////////////////////
// UISearchDisplayController Delegate Methods
- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    CompanySearchDataSource *ds = self.dataSource;
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

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
    CompanySearchDataSource *ds = self.dataSource;
    [ds filterContentForSearchText:searchText scope:scope];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    CompanySearchDataSource *ds = self.dataSource;
    ds.searchActive = NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////
//NSObject
- (void)dealloc {
	[super dealloc];
}

@end
