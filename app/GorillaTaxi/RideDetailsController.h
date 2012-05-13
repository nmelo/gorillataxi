//
//  GorillaCab Mobile App
//
//  Created by Nelson Melo on 5/11/12.
//  Copyright 2012 CodeModLabs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface RideDetailsController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>  {
    
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
