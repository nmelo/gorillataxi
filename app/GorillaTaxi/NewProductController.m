//
//  NewProductViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "NewProductController.h"
#import "DisplayMap.h"

@implementation NewProductController

@synthesize acceptButton, map, txt;

CEPubnub *pubnub;
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}

- (void)loadView {
	[super loadView];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIImage* background = [UIImage imageNamed:@"GC_background.png"];
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

    self.txt = [[UITextView alloc] initWithFrame:CGRectMake(20, 390, 280, 100)];
    [self.view addSubview:txt];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 25.781894;
    zoomLocation.longitude= -80.190057;
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
    
    DisplayMap *ann = [[DisplayMap alloc] init]; 
    ann.title = @" Kolkata";
    ann.subtitle = @"Mahatma Gandhi Road"; 
    ann.coordinate = adjustedRegion.center; 
    [map addAnnotation:ann];
    
    pubnub = [[CEPubnub alloc] initWithPublishKey:@"pub-94da0339-155d-4d8e-9f92-04901bd8ad70" subscribeKey:@"sub-1d545368-9c3f-11e1-b15f-0132dae9fae6" secretKey:@"sec-ZGQxZmJlNWEtYTA2Ni00YzBjLWE5YWMtZDkzZjg4MjgzOTU0"   cipherKey:@"demo" useSSL:NO];
    //subscribe to a few channels
    
    [pubnub setDelegate:self];
    
    [pubnub subscribe: @"hello_world"];

    NSString * text=@"Hi there!!!";
    [pubnub publish:[NSDictionary dictionaryWithObjectsAndKeys:@"hello_world",@"channel",text,@"message", nil]];

}

#pragma mark -
#pragma mark CEPubnubDelegate stuff
- (void) pubnub:(CEPubnub*)pubnub didSucceedPublishingMessageToChannel:(NSString*)channel
{
}
- (void) pubnub:(CEPubnub*)pubnub didFailPublishingMessageToChannel:(NSString*)channel error:(NSString*)error// "error" may be nil
{
    NSLog(@"didFailPublishingMessageToChannel   %@",error);
}
- (void) pubnub:(CEPubnub*)pubnub subscriptionDidReceiveDictionary:(NSDictionary *)message onChannel:(NSString *)channel{
    
    NSLog(@"subscriptionDidReceiveDictionary   ");
    [txt setText:[NSString stringWithFormat:@"sub on channel (dict) : %@ - received:\n %@", channel, message]];
    
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
    [txt setText:[NSString stringWithFormat:@"sub on channel (dict) : %@ - received\n: %@", channel, message]];
}
- (void) pubnub:(CEPubnub*)pubnub subscriptionDidReceiveString:(NSString *)message onChannel:(NSString *)channel{
    NSLog(@"subscriptionDidReceiveString   ");
    NSLog(@"Sescribe   %@",message);
    [txt setText:[NSString stringWithFormat:@"sub on channel (dict) : %@ - received:\n %@", channel, message]];
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
    [txt setText:[NSString stringWithFormat:@"History on channel (dict) : %@ - received:\n %@", channel, histry]];
    NSLog(@"Finesh didFetchHistory");
}  // "messages" will be nil on failure

- (void) pubnub:(CEPubnub*)pubnub didReceiveTime:(NSTimeInterval)time{
    NSLog(@"didReceiveTime   %f",time );
    
    [txt setText:[NSString stringWithFormat:@"Time  :- received:\n %f", time]];
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
