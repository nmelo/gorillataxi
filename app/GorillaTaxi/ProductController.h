#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>

@interface ProductController : TTViewController {
    
    IBOutlet TTLabel *productName;
    IBOutlet TTLabel *modelName;
}

@property(nonatomic, retain) IBOutlet TTLabel *productName;
@property(nonatomic, retain) IBOutlet TTLabel *modelName;

@end
