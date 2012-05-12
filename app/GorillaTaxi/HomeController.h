#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>

#import "DBProduct.h"

@interface HomeController : TTTableViewController<TTTabDelegate> {
    UISegmentedControl *segmentedControl; 
    
    NSString* _resourcePath;
	Class _resourceClass;
    
}

@property (nonatomic, retain) NSString* _resourcePath;
@property (nonatomic, retain) Class _resourceClass;

- (id<TTTableViewDataSource>)getDataSourceWithIndex:(NSInteger) selectedIndex;

@end
