//
//  TrackerSampleViewController.m
//  TrackerSample
//
//  Copyright (c) 2012 Geoloqi, Inc. All rights reserved.
//

#import "TrackerSampleViewController.h"
#import "JSONKit.h"


@implementation TrackerSampleViewController

@synthesize currentTrackingProfile;
@synthesize pushNotificationStatus;
@synthesize registerForPushButton;
@synthesize currentLocationField, currentLocationActivityIndicator;
@synthesize pushNotificationAlerts, pushNotificationBadges, pushNotificationSounds;
@synthesize webview;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.currentTrackingProfile.selectedSegmentIndex = [self segmentIndexForTrackingProfile:[[LQTracker sharedTracker] profile]];
    [self refreshPushNotificationStatus];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // Tell the SDK the user is currently interacting with the app, which gives it a chance to re-register location updates if needed
    [[LQTracker sharedTracker] appDidBecomeActive];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark -

- (void)refreshPushNotificationStatus
{
    self.pushNotificationAlerts.highlighted = [LQSession savedSession].pushAlertsEnabled;
    self.pushNotificationSounds.highlighted = [LQSession savedSession].pushSoundsEnabled;
    self.pushNotificationBadges.highlighted = [LQSession savedSession].pushBadgesEnabled;
    if([LQSession savedSession].pushAlertsEnabled) {
        self.pushNotificationStatus.text = @"Push notifications are enabled";
    } else {
        self.pushNotificationStatus.text = @"Push notifications are not enabled";
    }
}

- (int)segmentIndexForTrackingProfile:(LQTrackerProfile)profile
{
    switch(profile) {
        case LQTrackerProfileOff:      return 0;
        case LQTrackerProfilePassive:  return 1;
        case LQTrackerProfileRealtime: return 2;
        case LQTrackerProfileLogging:  return 3;
    }
}

- (LQTrackerProfile)profileForSegmentIndex:(int)index
{
    switch(index) {
        case 0: return LQTrackerProfileOff;
        case 1: return LQTrackerProfilePassive;
        case 2: return LQTrackerProfileRealtime;
        case 3: return LQTrackerProfileLogging;
        default: return LQTrackerProfileOff;
    }
}

- (IBAction)trackingProfileWasTapped:(UISegmentedControl *)sender
{
    NSLog(@"Tapped %d", sender.selectedSegmentIndex);
    [[LQTracker sharedTracker] setProfile:[self profileForSegmentIndex:sender.selectedSegmentIndex]];
    
    
}

#pragma mark -

- (IBAction)registerForPushWasTapped:(UIButton *)sender
{
    [LQSession registerForPushNotificationsWithCallback:^(NSData *deviceToken, NSError *error) {
        [self refreshPushNotificationStatus];
        if(error){
            self.pushNotificationStatus.text = [NSString stringWithFormat:@"Error: %@", [error localizedDescription]];
            NSLog(@"Failed to register for push tokens: %@", error);
        } else {
            self.pushNotificationStatus.text = [NSString stringWithFormat:@"Successfully registered! %@", deviceToken];
            NSLog(@"Got a push token! %@", deviceToken);
        }
    }];
    
    
}

- (IBAction)getLocationButtonWasTapped:(UIButton *)sender
{
    self.currentLocationField.text = @"Loading...";
    self.currentLocationActivityIndicator.hidden = NO;
    NSURLRequest *req = [[LQSession savedSession] requestWithMethod:@"GET" path:@"/location/context" payload:nil];
    
	[[LQSession savedSession] runAPIRequest:req completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error) {
		NSLog(@"Response: %@ error:%@", responseDictionary, error);
        if(error) {
            self.currentLocationField.text = [error localizedDescription];
        } else {
            NSMutableArray *loc = [NSMutableArray arrayWithCapacity:4];
            if([responseDictionary objectForKey:@"intersection"]) {
                [loc addObject:[responseDictionary objectForKey:@"intersection"]];
            }
            if([responseDictionary objectForKey:@"locality_name"]) {
                [loc addObject:[responseDictionary objectForKey:@"locality_name"]];
            }
            if([responseDictionary objectForKey:@"region_name"]) {
                [loc addObject:[responseDictionary objectForKey:@"region_name"]];
            }
            if([responseDictionary objectForKey:@"country_name"]) {
                [loc addObject:[responseDictionary objectForKey:@"country_name"]];
            }
            self.currentLocationField.text = [loc componentsJoinedByString:@", "];
        }
        self.currentLocationActivityIndicator.hidden = YES;
	}];
}

- (IBAction)createLinkAction:(id)sender
{
    NSLog(@"Create link action starting.");
    
     /*
    NSMutableDictionary *groupObject = [[NSMutableDictionary alloc] init];
    
    [groupDictionary setObject:@"Ride" forKey:@"title"];
    [groupDictionary setObject:@"open" forKey:@"visibility"];
    [groupDictionary setObject:@"open" forKey:@"publish_access"];

   
    NSURLRequest *createGroupRequest = [[LQSession savedSession] requestWithMethod:@"POST" path:@"/group/create" payload:[groupObject JSONData]];
    
    [[LQSession savedSession] runAPIRequest:createGroupRequest completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error){
        NSLog(@"Response: %@ error%@", responseDictionary, error);
        if(error)
        {
            self.currentLocationField.text = [error localizedDescription];
        }
    }];
     
     {
     "group_token" = ff9UkfH1L;
     }
    */
    
    /*
    NSURLRequest *createLinkRequest = [[LQSession savedSession] requestWithMethod:@"POST" path:@"/link/create" payload:nil];
    
    [[LQSession savedSession] runAPIRequest:createLinkRequest completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error){
        NSLog(@"Response: %@ error%@", responseDictionary, error);
        if(error)
        {
            self.currentLocationField.text = [error localizedDescription];
        }
        else
        {
            NSString *token = [responseDictionary objectForKey:@"token"];
            

        }

    }];
    
    {
        "can_facebook" = 0;
        "can_tweet" = 0;
        link = "https://geoloqi.com/_1UBwK1i94uvwD33FH/x_ihrV4";
        shortlink = "http://loqi.me/x_ihrV4";
        token = "x_ihrV4";
    } 
    
    */
    
    
    //NSString *shareToken = [[NSString alloc] initWithFormat:@"share_token=%@", @"2134"];
    NSMutableDictionary *messageObject = [[NSMutableDictionary alloc] init];
    [messageObject setObject:@"Do you want to take a ride with me?" forKey:@"text"];
    [messageObject setObject:@"http://loqi.me/x_ihrV4" forKey:@"url"];
    
    NSURLRequest *createMessageRequest = [[LQSession savedSession] requestWithMethod:@"POST" path:@"/group/message/ff9UkfH1L" payload:messageObject];
    
    [[LQSession savedSession] runAPIRequest:createMessageRequest completion:^(NSHTTPURLResponse *response, NSDictionary *responseDictionary, NSError *error){
        NSLog(@"Response: %@ error%@", responseDictionary, error);
        if(error)
        {
            self.currentLocationField.text = [error localizedDescription];
        }
    }];
    
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"map.html"];

    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSString *html = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:NULL];
        
        [self.webview loadHTMLString:html baseURL:nil];
    }
}


@end
