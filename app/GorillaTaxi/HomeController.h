#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>

@interface HomeController : TTViewController{
    UIButton *driveButton;
    UIButton *requestButton;
}

@property (nonatomic, retain) UIButton *driveButton;
@property (nonatomic, retain) UIButton *requestButton;
- (IBAction)drive_OnClick;
- (IBAction)request_OnClick;
@end
