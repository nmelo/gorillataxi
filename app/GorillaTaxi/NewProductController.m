//
//  NewProductViewController.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/13/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "NewProductController.h"
#import "AppDelegate.h"

@implementation NewProductController

@synthesize acceptButton, map, txt, ann;

CEPubnub *pubnub;
///////////////////////////////////////////////////////////////////////////////////////////////////
// TTViewController
- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    return self;
}

- (void)loadView {
	[super loadView];
    
    self.navigationController.navigationBar.hidden = YES;
        
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 25.781894;
    zoomLocation.longitude= -80.190057;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 42, 320, 440)];
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
//    [self apiFQLIMe];

//    self.txt = [[UITextView alloc] initWithFrame:CGRectMake(20, 390, 280, 100)];
//    [self.view addSubview:txt];

}

/**
 * Make a Graph API Call to get information about the current logged in user.
 */
- (void)apiFQLIMe {
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name, pic FROM user WHERE uid=me()", @"query",
                                   nil];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}

- (void)apiGraphUserPermissions {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
}


/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    if ([result objectForKey:@"name"]) {
        // If basic information callback, set the UI objects to
        // display this.
//        ann.title = [result objectForKey:@"name"];
        // Get the profile image
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[result objectForKey:@"pic"]]]];
        
        // Resize, crop the image to make sure it is square and renders
        // well on Retina display
        float ratio;
        float delta;
        float px = 100; // Double the pixels of the UIImageView (to render on Retina)
        CGPoint offset;
        CGSize size = image.size;
        if (size.width > size.height) {
            ratio = px / size.width;
            delta = (ratio*size.width - ratio*size.height);
            offset = CGPointMake(delta/2, 0);
        } else {
            ratio = px / size.height;
            delta = (ratio*size.height - ratio*size.width);
            offset = CGPointMake(0, delta/2);
        }
        CGRect clipRect = CGRectMake(-offset.x, -offset.y,
                                     (ratio * size.width) + delta,
                                     (ratio * size.height) + delta);
        UIGraphicsBeginImageContext(CGSizeMake(px, px));
        UIRectClip(clipRect);
        [image drawInRect:clipRect];
        UIImage *imgThumb = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        ann.image = imgThumb;
        
        [self apiGraphUserPermissions];
    } else {
        // Processing permissions information
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate setUserPermissions:[[result objectForKey:@"data"] objectAtIndex:0]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
//    pubnub = [[CEPubnub alloc] initWithPublishKey:@"pub-94da0339-155d-4d8e-9f92-04901bd8ad70" subscribeKey:@"sub-1d545368-9c3f-11e1-b15f-0132dae9fae6" secretKey:@"sec-ZGQxZmJlNWEtYTA2Ni00YzBjLWE5YWMtZDkzZjg4MjgzOTU0"   cipherKey:@"demo" useSSL:NO];
//    //subscribe to a few channels
//    
//    [pubnub setDelegate:self];
//    
//    [pubnub subscribe: @"hello_world"];
//
//    NSString * text=@"Hi there!!!";
//    [pubnub publish:[NSDictionary dictionaryWithObjectsAndKeys:@"hello_world",@"channel",text,@"message", nil]];

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
        pinView.animatesDrop = NO;
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
