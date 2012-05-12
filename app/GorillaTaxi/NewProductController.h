//
//  NewProductViewController.h
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>
#import <MapKit/MapKit.h>

#import "CEPubnub.h"
#import "DisplayMap.h"
#import "FBConnect.h"

#define METERS_PER_MILE 1609.344

@interface NewProductController : TTViewController <MKMapViewDelegate, CEPubnubDelegate, FBRequestDelegate,
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
