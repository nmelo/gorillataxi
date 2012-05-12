#import "TabBarController.h"

@implementation TabBarController


///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabURLs:[NSArray arrayWithObjects:@"db://home",
                      @"db://new",
                      @"db://brands",
                      nil]];
    self.selectedIndex = 0;
} 

@end
