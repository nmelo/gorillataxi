#import "FeedbackDataSource.h"

@implementation FeedbackDataSource

///////////////////////////////////////////////////////////////////////////////////////////////////
//Implementing custom cells
- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object {
    
    //Three20 requires I return the class of my custom cell. 
    return [FeedbackItemCell class];
    
    if ([object isKindOfClass:[FeedbackItemCell class]]) { 
		return [FeedbackItemCell class]; 		
	} else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
}

@end