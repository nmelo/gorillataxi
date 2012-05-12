#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import <RestKit/Three20/Three20.h>
#import <MapKit/MapKit.h>
#import "DisplayMap.h"
#import "CEPubnub.h"

#define METERS_PER_MILE 1609.344

@interface HomeController : TTViewController <MKMapViewDelegate, CEPubnubDelegate >{
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
@end
