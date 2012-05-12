#import "ProductSearchDataSource.h"

@implementation ProductSearchDataSource

@synthesize filteredItems,  searchActive, searchText;


-(void)initializeFilteredContent {
    [self setFilteredItems:[NSMutableArray arrayWithCapacity:[self.items count]]];
}
///////////////////////////////////////////////////////////////////////////////////////////////////
//UITableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchActive && (self.searchText != nil)) {
        return self.filteredItems.count;
    } 
    else {
        return self.items.count;
    }
}


- (void)filterContentForSearchText:(NSString*)searchedText scope:(NSString*)scope {
    [self.filteredItems removeAllObjects]; // First clear the filtered array.
    
    self.searchText = searchedText;
    
    for (TTTableImageItem *item in _items) {
        NSComparisonResult result = [item.text compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame) {
            [self.filteredItems addObject:item];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    TTTableImageItem *item = nil;
    
    if (searchActive)
    {
        item = [self.filteredItems objectAtIndex:indexPath.row];
    }
    else
    {
        item = [self.items objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = item.text;
    
    return cell;
}

@end