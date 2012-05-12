#import "HomeController.h"

//This is the popularity algorithm we are going to use. Taken from stackoverflow. 
//http://meta.stackoverflow.com/questions/11602/what-formula-should-be-used-to-determine-hot-questions
/*
 Iviews = Views of the item
 Iscore = Upvotes on the item - Downvotes on the item
 Fscore = Upvotes on the feedback - Downvotes on the feedback
 Iage   = Days the item has been on the system
 Iupdated = When was a new item of the same type last posted.  
 
 (log(Iviews)*4) + ((Ifeedbacks * Iscore)/5) + sum(Fscore)
 --------------------------------------------------------
 ((Iage+1) - ((Iage - Iupdated)/2)) ^ 1.5
 */

@implementation HomeController

@synthesize driveButton, requestButton, map, ann;

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//TTTableViewController
- (void)createModel {
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBActions
- (void)drive_OnClick
{
    TTOpenURL(@"db://product");
}
- (void)request_OnClick
{
    TTOpenURL(@"db://product");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//UIViewController
- (void)loadView {
    [super loadView];
    self.navigationController.navigationBar.hidden = YES;
    
    UIImage* or = [UIImage imageNamed:@"or.png"];
	UIImageView* orImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 380, 320, 83)];
	[orImage setImage:or];
    [self.view addSubview:orImage];
    
    UIImage* drive_image = [UIImage imageNamed:@"drive.png"];
    self.driveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.driveButton.frame = CGRectMake(20, 397, 111, 41);
    [self.driveButton setBackgroundImage:drive_image forState:UIControlStateNormal];
    [self.driveButton  addTarget:self action:@selector(drive_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:driveButton];

    UIImage* request_image = [UIImage imageNamed:@"ride.png"];
    self.requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.requestButton.frame = CGRectMake(188, 397, 111, 41);
    [self.requestButton setBackgroundImage:request_image forState:UIControlStateNormal];
    [self.requestButton  addTarget:self action:@selector(request_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestButton];
    
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 25.781894;
    zoomLocation.longitude= -80.190057;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 42, 320, 338)];
    MKCoordinateRegion adjustedRegion = [map regionThatFits:viewRegion];                
    [map setMapType:MKMapTypeStandard];
    [map setZoomEnabled:YES];
    [map setScrollEnabled:YES];
    [map setDelegate:self];
    // 4
    [map setRegion:adjustedRegion animated:YES];
    [self.view addSubview:map];
    
    ann = [[DisplayMap alloc] init]; 
    ann.title = @"Hi";
    ann.subtitle = @"hello";
    ann.coordinate = adjustedRegion.center; 
    [map addAnnotation:ann];
    
    UIImage* header = [UIImage imageNamed:@"header.png"];
	UIImageView* headerBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
	[headerBackgroundImage setImage:header];
    [self.view addSubview:headerBackgroundImage];
    [self.view sendSubviewToBack:headerBackgroundImage];
}

#pragma mark -
#pragma mark CEPubnubDelegate stuff

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
        pinView.animatesDrop = NO;
    } 
    else {
        [map.userLocation setTitle:@"I am here"];
    }
    return pinView;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
}


@end
