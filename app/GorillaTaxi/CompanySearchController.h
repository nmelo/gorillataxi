//
//  BrandSearchViewController.h
//  MobileFeedback
//
//  Created by Nelson Melo on 4/16/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import "DBCompany.h"
#import "CompanySearchDataSource.h"

@interface CompanySearchController : TTTableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
    	
	// The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    
	NSString* _resourcePath;
	Class _resourceClass;
    
    UISearchDisplayController *searchDisplayController;
}

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;

@property (nonatomic, retain) NSString* _resourcePath;
@property (nonatomic, retain) Class _resourceClass;
@property (nonatomic, retain) UISearchDisplayController *searchDisplayController;


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;

@end