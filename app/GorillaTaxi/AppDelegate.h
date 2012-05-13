//
//  GorillaCab Mobile App
//
//  Created by Nelson Melo on 5/11/12.
//  Copyright 2012 CodeModLabs LLC. All rights reserved.
//

#import "HomeController.h"
#import "SignUpController.h"

#import "LQSession.h"
#import "LQTracker.h"


@interface AppDelegate : NSObject <UIApplicationDelegate> {
    Facebook *facebook;
}

@property(nonatomic, retain) Facebook *facebook;
@end