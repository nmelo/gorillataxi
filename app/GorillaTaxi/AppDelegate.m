#import "AppDelegate.h"

@implementation AppDelegate

@synthesize facebook;

///////////////////////////////////////////////////////////////////////////////////////////////////
//Three20
- (void) initThree20 {
    
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.persistenceMode = TTNavigatorPersistenceModeAll;
    navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
    
    TTURLMap* map = navigator.URLMap;
    
    [map from:@"*" toViewController:[TTWebController class]];

    [map from:@"db://signup" toViewController:[SignUpController class]];
    [map from:@"db://leaveFeedback" toViewController:[LeaveFeedbackController class]];
    
    [map from:@"db://home" toViewController:[HomeController class]];
    [map from:@"db://new" toViewController:[ProductSearchController class]];
    [map from:@"db://brands" toViewController:[CompanySearchController class]];
    
    [map from:@"db://product/(initWithID:)" toViewController:[ProductController class]];
    [map from:@"db://company/(initWithID:)" toViewController:[CompanyController class]];
    
    [map from:@"db://newProduct" toViewController:[NewProductController class]];
    [map from:@"db://newFeedback/(initWithProdID:)" toViewController:[NewFeedbackController class]];
    [map from:@"db://feedbackType/(initWithFeedbackID:)" toViewController:[FeedbackTypeController class]];
    [map from:@"db://feedbackText/(initWithFeedbackID:)" toViewController:[FeedbackTextController class]];
    
    
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0]; // Don't limit content length.	
    
    // Fire up the UI!
	TTOpenURL(@"db://home");
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// RestKit
- (void)initRestKit {
    
    // Initialize RestKit
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:DBRestKitBaseURL];
    
    // Set the default refresh rate to 1. This means we should always hit the web if we can.
	// If the server is unavailable, we will load from the Core Data cache.
	[RKRequestTTModel setDefaultRefreshRate:1];

    // Set nil for any attributes we expect to appear in the payload, but do not
    objectManager.mapper.missingElementMappingPolicy = RKSetNilForMissingElementMappingPolicy;

    //Default password used by the Rails interface to access json. Must change later. 
    objectManager.client.username = @"foo"; 
    objectManager.client.password = @"bar"; 
    
    // Initialize object store
//    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"DB.sqlite"];
//    objectManager.objectStore.managedObjectCache = [[DBManagedObjectCache new] autorelease];
    
    // Add our element to object mappings
    RKObjectMapper* mapper = objectManager.mapper;	    
    [mapper registerClass:[DBCompany class] forElementNamed:@"company"];
    [mapper registerClass:[DBProduct class] forElementNamed:@"product"];
    [mapper registerClass:[DBVote class] forElementNamed:@"vote"];
    [mapper registerClass:[DBFeedback class] forElementNamed:@"feedback"];
    [mapper registerClass:[DBUser class] forElementNamed:@" "];
    
    RKRailsRouter* router = [[[RKRailsRouter alloc] init] autorelease];
    
    //DBUser
    [router setModelName:@"android_user" forClass:[DBUser class]];
	[router routeClass:[DBUser class] toResourcePath:@"/android_users" forMethod:RKRequestMethodPOST];
	[router routeClass:[DBUser class] toResourcePath:@"/android_users/(user_id)" forMethod:RKRequestMethodPUT];
	[router routeClass:[DBUser class] toResourcePath:@"/android_users/(user_id)" forMethod:RKRequestMethodDELETE];

    //DBCompany
    [router setModelName:@"company" forClass:[DBCompany class]];
    [router routeClass:[DBCompany class] toResourcePath:@"/companies" forMethod:RKRequestMethodPOST];
    [router routeClass:[DBCompany class] toResourcePath:@"/company/(company_id)" forMethod:RKRequestMethodPUT];
    [router routeClass:[DBCompany class] toResourcePath:@"/company/(company_id)" forMethod:RKRequestMethodDELETE];
    
    //DBProduct
    [router setModelName:@"product" forClass:[DBProduct class]];
	[router routeClass:[DBProduct class] toResourcePath:@"/products" forMethod:RKRequestMethodPOST];
	[router routeClass:[DBProduct class] toResourcePath:@"/product/(product_id)" forMethod:RKRequestMethodPUT];
	[router routeClass:[DBProduct class] toResourcePath:@"/product/(product_id)" forMethod:RKRequestMethodDELETE];
    
    //DBFeedback
    [router setModelName:@"feedback" forClass:[DBFeedback class]];

    //Registering two classes for the "feedback" model to account for the polimorfism on FeedbackableController.
    //DBCompanyFeedback    
    [router setModelName:@"feedback" forClass:[DBProductFeedback class]];
    [router routeClass:[DBProductFeedback class] toResourcePath:@"/products/(product_id)/feedbacks" forMethod:RKRequestMethodPOST];
    
    //DBCompanyFeedback    
    [router setModelName:@"feedback" forClass:[DBCompanyFeedback class]];
    [router routeClass:[DBCompanyFeedback class] toResourcePath:@"/companies/(company_id)/feedbacks" forMethod:RKRequestMethodPOST];

    //DBVote
    [router setModelName:@"vote" forClass:[DBVote class]];
	[router routeClass:[DBVote class] toResourcePath:@"/votes" forMethod:RKRequestMethodPOST];
	[router routeClass:[DBVote class] toResourcePath:@"/votes/(vote_id)" forMethod:RKRequestMethodPUT];
	[router routeClass:[DBVote class] toResourcePath:@"/votes/(vote_id)" forMethod:RKRequestMethodDELETE];
    
    
    objectManager.router = router;
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    //Initialize facebook instance. 
    // App Secret:	31c5abda46b48e1bf294736f4730b8ce
    facebook = [[Facebook alloc] initWithAppId:@"357273454322052"]; 
    
    //Stup ObjectMapper, Router and Navigator. 
    [self initRestKit];
    
    //Setup TTNavigator and map.
    [self initThree20];
    
    //Launch the app. 
    [[TTNavigator navigator].window makeKeyAndVisible];

    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// Facebook Handle Return URL
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [facebook handleOpenURL:url]; 
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    //Logout the user as soon as the app ends. 
    //[[DBUser currentUser] logout];
    
}
    
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject
- (void)dealloc {    
    [super dealloc];
}


@end
