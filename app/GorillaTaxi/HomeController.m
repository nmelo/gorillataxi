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

@synthesize driveButton, requestButton;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//TTTableViewController
- (void)createModel {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//UIViewController
- (void)loadView {
    [super loadView];
    
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    
    UIImage* drive_image = [UIImage imageNamed:@"drive.png"];
    self.driveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.driveButton.frame = CGRectMake(40, 385, 160, 38);
    [self.driveButton setBackgroundImage:drive_image forState:UIControlStateNormal];
    [self.view addSubview:driveButton];

    UIImage* request_image = [UIImage imageNamed:@"request.png"];
    self.requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.requestButton.frame = CGRectMake(240, 385, 160, 38);
    [self.requestButton setBackgroundImage:request_image forState:UIControlStateNormal];
    [self.view addSubview:requestButton];

    
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
