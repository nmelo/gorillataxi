//
//  GorillaCab Mobile App
//
//  Created by Nelson Melo on 5/11/12.
//  Copyright 2012 CodeModLabs LLC. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "DisplayMap.h"
#import "FBConnect.h"

#define METERS_PER_MILE 1609.344

@interface NavigationController : UIViewController <MKMapViewDelegate, FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate>
{
    UIButton *acceptButton;
    IBOutlet MKMapView *map;
    IBOutlet UITextView *txt;
    DisplayMap * ann;
    
}

@property (nonatomic, retain) UIButton *acceptButton;
@property(nonatomic, retain) IBOutlet MKMapView *map;
@property (retain, nonatomic) IBOutlet UITextView *txt;
@property (retain, nonatomic) DisplayMap * ann;
- (IBAction)accept_OnClick;

@end
