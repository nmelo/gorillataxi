//
//  DBEnvironment.m
//  DiscussionBoard
//
//  Created by Nelson Melo on 1/7/11.
//  Copyright 2011 CodeModLabs LLC. All rights reserved.
//

#import "DBEnvironment.h"

// Base URL
#if DB_ENVIRONMENT == DB_ENVIRONMENT_DEVELOPMENT
NSString* const DBRestKitBaseURL = @"http://atthackmiami.appspot.com";
#elif DB_ENVIRONMENT == DB_ENVIRONMENT_STAGING
// TODO: Need a staging environment...
#elif DB_ENVIRONMENT == DB_ENVIRONMENT_PRODUCTION
NSString* const DBRestKitBaseURL = @"http://atthackmiami.appspot.com";
#endif
