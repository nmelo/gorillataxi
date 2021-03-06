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

#import "Geoloqi.h"
#import "LQConfig.h"

#define METERS_PER_MILE 1609.344

@interface HomeController : UIViewController <MKMapViewDelegate>{
    UIButton *driveButton;
    UIButton *requestButton;
    IBOutlet MKMapView *map;
    DisplayMap * ann;
    BOOL isDriver;
}

@property (nonatomic, retain) UIButton *driveButton;
@property (nonatomic, retain) UIButton *requestButton;
@property(nonatomic, retain) IBOutlet MKMapView *map;
@property(nonatomic, retain) DisplayMap * ann;
@property(nonatomic) BOOL isDriver;
- (IBAction)drive_OnClick;
- (IBAction)request_OnClick;


@property (strong) IBOutlet UISegmentedControl *currentTrackingProfile;
@property (strong) IBOutlet UITextView *pushNotificationStatus;
@property (strong) IBOutlet UIButton *registerForPushButton;
@property (strong) IBOutlet UILabel *currentLocationField;
@property (strong) IBOutlet UIActivityIndicatorView *currentLocationActivityIndicator;


@property (strong) IBOutlet UIButton *pushNotificationAlerts;
@property (strong) IBOutlet UIButton *pushNotificationBadges;
@property (strong) IBOutlet UIButton *pushNotificationSounds;

@property (strong) IBOutlet UIWebView *webview;


- (IBAction)createLinkAction:(id)sender;
- (IBAction)trackingProfileWasTapped:(UISegmentedControl *)sender;
- (IBAction)registerForPushWasTapped:(UIButton *)sender;
- (IBAction)getLocationButtonWasTapped:(UIButton *)sender;
- (int)segmentIndexForTrackingProfile:(LQTrackerProfile)profile;

- (void)refreshPushNotificationStatus;

@end
