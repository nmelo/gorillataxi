#import "FeedbackableController.h"
#import "DBEnvironment.h"

@interface ProductController : FeedbackableController {
    
    IBOutlet TTLabel *productName;
    IBOutlet TTLabel *modelName;
    IBOutlet TTImageView *productImage;
}

@property(nonatomic, retain) IBOutlet TTLabel *productName;
@property(nonatomic, retain) IBOutlet TTLabel *modelName;
@property(nonatomic, retain) IBOutlet TTImageView *productImage;

@end
