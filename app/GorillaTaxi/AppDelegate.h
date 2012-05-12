#import <Three20/Three20.h>
#import <Three20/Three20+Additions.h>

#import "HomeController.h"
#import "ProductController.h"

#import "CompanySearchController.h"
#import "CompanyController.h"

#import "ProductSearchController.h"

#import "NewProductController.h"
#import "ConfirmationController.h"
#import "PassengerConfirmationController.h"
#import "DriverConfirmationController.h"
#import "SignUpController.h"
#import "LeaveFeedbackController.h"
#import "NewFeedbackController.h"
#import "FeedbackTypeController.h"
#import "FeedbackTextController.h"

#import "DBUser.h"
#import "DBVote.h"
#import "DBProduct.h"
#import "DBFeedback.h"
#import "DBCompany.h"
#import "DBCompanyFeedback.h"
#import "DBProductFeedback.h"

#import "DBEnvironment.h"

#import <RestKit/RestKit.h>
#import <RestKit/ObjectMapping/RKRailsRouter.h>
#import <RestKit/Three20/Three20.h>

#import "DBManagedObjectCache.h"

@class DBCompany, DBVote, DBFeedback, DBUser, DBProduct; 

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    Facebook *facebook;
}

@property(nonatomic, retain) Facebook *facebook;
@end