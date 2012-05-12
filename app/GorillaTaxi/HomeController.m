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
// IBActions
- (void)drive_OnClick
{
    TTOpenURL(@"db://product");
}
- (void)request_OnClick
{
    TTOpenURL(@"db://product");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//UIViewController
- (void)loadView {
    [super loadView];
    self.navigationController.navigationBar.hidden = YES;
    
    UIImage* background = [UIImage imageNamed:@"GC_background.png"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	[headerBackgroundImage setImage:background];
    [self.view addSubview:headerBackgroundImage];
    [self.view sendSubviewToBack:headerBackgroundImage];
    
    UIImage* drive_image = [UIImage imageNamed:@"drive.png"];
    self.driveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.driveButton.frame = CGRectMake(20, 385, 133, 38);
    [self.driveButton setBackgroundImage:drive_image forState:UIControlStateNormal];
    [self.driveButton  addTarget:self action:@selector(drive_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:driveButton];

    UIImage* request_image = [UIImage imageNamed:@"request.png"];
    self.requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.requestButton.frame = CGRectMake(170, 385, 133, 38);
    [self.requestButton setBackgroundImage:request_image forState:UIControlStateNormal];
    [self.requestButton  addTarget:self action:@selector(request_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestButton];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
}


@end
