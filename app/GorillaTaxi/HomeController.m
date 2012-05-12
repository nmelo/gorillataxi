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

@synthesize driveButton, requestButton, map, ann, isDriver;
CEPubnub *pubnub;
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
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle: @"Success"
                               message: @"We'll notify you when a passenger requests a ride."
                              delegate: self
                     cancelButtonTitle: @"Done"
                     otherButtonTitles: nil];
    [alert show];
    [alert release];
    
    NSString * text=@"Driver found.";
    [pubnub publish:[NSDictionary dictionaryWithObjectsAndKeys:@"hello_world",@"channel",text,@"message", nil]];
    isDriver = YES;

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
	UIImageView* orImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 400, 320, 83)];
	[orImage setImage:or];
    [self.view addSubview:orImage];
    
    UIImage* drive_image = [UIImage imageNamed:@"drive.png"];
    self.driveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.driveButton.frame = CGRectMake(20, 417, 111, 41);
    [self.driveButton setBackgroundImage:drive_image forState:UIControlStateNormal];
    [self.driveButton  addTarget:self action:@selector(drive_OnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:driveButton];

    UIImage* request_image = [UIImage imageNamed:@"ride.png"];
    self.requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.requestButton.frame = CGRectMake(188, 417, 111, 41);
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
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 42, 320, 358)];
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
    
    pubnub = [[CEPubnub alloc] initWithPublishKey:@"pub-94da0339-155d-4d8e-9f92-04901bd8ad70" subscribeKey:@"sub-1d545368-9c3f-11e1-b15f-0132dae9fae6" secretKey:@"sec-ZGQxZmJlNWEtYTA2Ni00YzBjLWE5YWMtZDkzZjg4MjgzOTU0"   cipherKey:@"demo" useSSL:NO];
    //subscribe to a few channels
    [pubnub setDelegate:self];
    
    [pubnub subscribe: @"hello_world"];
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
// PUBNUB
- (void) pubnub:(CEPubnub*)pubnub didSucceedPublishingMessageToChannel:(NSString*)channel
{
}
- (void) pubnub:(CEPubnub*)pubnub didFailPublishingMessageToChannel:(NSString*)channel error:(NSString*)error// "error" may be nil
{
    NSLog(@"didFailPublishingMessageToChannel   %@",error);
}
- (void) pubnub:(CEPubnub*)pubnub subscriptionDidReceiveDictionary:(NSDictionary *)message onChannel:(NSString *)channel{
    
    NSLog(@"subscriptionDidReceiveDictionary   ");
    NSLog(@"Sescribe   %@",message);
    
    
    NSDictionary* disc=(NSDictionary*)message;
    for (NSString* key in [disc allKeys]) {
        //   NSLog(@"Key::%@",key);
        NSString* val=(NSString*)[disc objectForKey:key];
        NSLog(@"%@-->   %@",key,val);
    }
}

- (void) pubnub:(CEPubnub*)pubnub subscriptionDidReceiveArray:(NSArray *)message onChannel:(NSString *)channel{
    NSLog(@"subscriptionDidReceiveArray   ");
    NSLog(@"Sescribe   %@",message);
}
- (void) pubnub:(CEPubnub*)pubnub subscriptionDidReceiveString:(NSString *)message onChannel:(NSString *)channel{
    NSLog(@"subscriptionDidReceiveString   ");
    NSLog(@"Sescribe   %@",message);
    
    NSString * driverFound=@"Driver found.";
    NSString * passengerFound=@"Passenger found.";
    
    if(!isDriver && [message isEqualToString:driverFound]){
        TTOpenURL(@"db://passengerConfirm");
    }
    else if(isDriver && [message isEqualToString:passengerFound]){
        TTOpenURL(@"db://driverConfirm");
    }

}   

- (void) pubnub:(CEPubnub*)pubnub didFetchHistory:(NSArray*)messages forChannel:(NSString*)channel{
    int i=0;
    NSLog(@"didFetchHistory");
    NSMutableString *histry=  [[NSMutableString alloc]init ];
    for (NSString * object in messages) {
        NSLog(@"%d \n%@",i,object);
        [histry appendString:[NSString stringWithFormat:@"----%i\n%@",i,object]];
        
        i++;
        
    } 
    NSLog(@"Finesh didFetchHistory");
}  // "messages" will be nil on failure

- (void) pubnub:(CEPubnub*)pubnub didReceiveTime:(NSTimeInterval)time{
    NSLog(@"didReceiveTime   %f",time );
    
}  // "time" will be NAN on failure

#pragma mark -
#pragma mark CEPubnubDelegate stuff

- (IBAction)StringPublish:(id)sender {
    
	NSLog(@"-----------PUBLISH STRING----------------");
	
    
    NSString * text=@"Hello World";
    [pubnub publish:[NSDictionary dictionaryWithObjectsAndKeys:@"hello_world",@"channel",text,@"message", nil]];
}

- (IBAction)ArrayPublish:(id)sender {
    NSLog(@"-----------PUBLISH ARRAY----------------");
    
    [pubnub publish:[NSDictionary dictionaryWithObjectsAndKeys:@"hello_world",@"channel",[NSArray arrayWithObjects:@"seven", @"eight", [NSDictionary dictionaryWithObjectsAndKeys:@"Cheeseburger",@"food",@"Coffee",@"drink", nil], nil],@"message", nil]];
}

- (IBAction)DictionaryPublish:(id)sender {
    NSLog(@"-----------PUBLISH Dictionary----------------");
	
    
    
    [pubnub publish:[NSDictionary dictionaryWithObjectsAndKeys:@"hello_world",@"channel",[NSDictionary dictionaryWithObjectsAndKeys:@"X-code->ÇÈ°∂@#$%^&*()!",@"Editer",@"Objective-c",@"Language", nil],@"message", nil]];
}

- (IBAction)HistoryClick:(id)sender {
    NSLog(@"-----------HISTORY START----------------");
	
    
    
    
	
    NSInteger limit = 3;
    NSNumber * aWrappedInt = [NSNumber numberWithInteger:limit];    
    [pubnub fetchHistory:[NSDictionary dictionaryWithObjectsAndKeys: aWrappedInt,@"limit", @"hello_world",@"channel",nil]];
}

- (IBAction)TimeClick:(id)sender {
    NSLog(@"-----------TIME START----------------");
    [pubnub getTime];
}

- (IBAction)UUIDClick:(id)sender {
    NSLog(@"-----------UUID START----------------");
    NSLog(@"UUID::: %@",[CEPubnub getUUID]);
}



///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {
    [super dealloc];
}


@end
