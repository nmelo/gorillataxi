#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

@interface ProductSearchDataSource:TTListDataSource {
    
    // The saved state of the search UI if a memory warning removed the view.
    BOOL		searchActive;
    NSString    *searchText;
    
	NSMutableArray	*filteredItems;	// The content filtered as a result of a search.
    
}
@property (nonatomic) BOOL searchActive;
@property (nonatomic,retain)  NSString    *searchText;
@property (nonatomic, retain) NSMutableArray *filteredItems;

-(void)initializeFilteredContent;
- (void)filterContentForSearchText:(NSString*)searchedText scope:(NSString*)scope;

@end
