#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>
#import "CEPubnub.h"

@interface ProductController : TTViewController <UIPickerViewDataSource, UIPickerViewDelegate, CEPubnubDelegate>  {
    
    IBOutlet UIImageView *productName;
    IBOutlet UIImageView *modelName;
    IBOutlet UIImageView * getAride;
    IBOutlet UIButton *letsGoButton;
    IBOutlet UITextView *address;
    IBOutlet UITextView *price;
    NSMutableArray *prices;

}


@property(nonatomic, retain) IBOutlet UIButton *letsGoButton;
@property(nonatomic, retain) NSMutableArray *prices;
@property(nonatomic, retain) IBOutlet UIImageView *productName;
@property(nonatomic, retain) IBOutlet UIImageView *modelName;
@property(nonatomic, retain) IBOutlet UITextView *address;
@property(nonatomic, retain) IBOutlet UITextView *price;
@property(nonatomic, retain) IBOutlet UIImageView * getAride;


- (IBAction)letsGo_OnClick;

@end
