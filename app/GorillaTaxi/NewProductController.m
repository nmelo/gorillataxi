//
//  NewProductViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "NewProductController.h"

@implementation NewProductController

@synthesize acceptButton, map;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}

- (void)loadView {
	[super loadView];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIImage* background = [UIImage imageNamed:@"background.jpg"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
	[headerBackgroundImage setImage:background];
    [self.view addSubview:headerBackgroundImage];
    [self.view sendSubviewToBack:headerBackgroundImage];

    UIImage* accept_image = [UIImage imageNamed:@"accept.png"];
    self.acceptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.acceptButton.frame = CGRectMake(60, 340, 133, 38);
    [self.acceptButton setBackgroundImage:accept_image forState:UIControlStateNormal];
    [self.acceptButton  addTarget:self action:@selector(accept_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:acceptButton];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 25.777516;
    zoomLocation.longitude= -80.580806;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    map = [[MKMapView alloc] initWithFrame:CGRectMake(20, 20, 280, 300)];
    MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion];                
    [map setMapType:MKMapTypeStandard];
    [map setZoomEnabled:YES];
    [map setScrollEnabled:YES];
    [map setDelegate:self];
    // 4
    [map setRegion:adjustedRegion animated:YES];
    [self.view addSubview:map];

}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = nil; 
    if(annotation != map.userLocation) 
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
                                          initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
        
        pinView.pinColor = MKPinAnnotationColorRed; 
        pinView.canShowCallout = YES;
        pinView.animatesDrop = YES;
    } 
    else {
        [map.userLocation setTitle:@"I am here"];
    }
    return pinView;
}


- (void)accept_OnClick {
    TTOpenURL(@"db://confirm");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
}


@end
