#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>


@interface ProductController : TTViewController <UIPickerViewDataSource, UIPickerViewDelegate>  {
    
    IBOutlet TTLabel *productName;
    IBOutlet TTLabel *modelName;
    IBOutlet UIButton *letsGoButton;
    IBOutlet UITextView *address;
    IBOutlet UIPickerView *price;
    NSMutableArray *prices;

}


@property(nonatomic, retain) IBOutlet UIButton *letsGoButton;
@property(nonatomic, retain) NSMutableArray *prices;
@property(nonatomic, retain) IBOutlet TTLabel *productName;
@property(nonatomic, retain) IBOutlet TTLabel *modelName;
@property(nonatomic, retain) IBOutlet UITextView *address;
@property(nonatomic, retain) IBOutlet UIPickerView *price;


- (IBAction)letsGo_OnClick;

@end
