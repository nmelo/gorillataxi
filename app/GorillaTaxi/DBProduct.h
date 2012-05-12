//
//  DBProduct.h
//  Frankly
//
//  Created by Nelson Melo on 4/26/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>
#import "DBEnvironment.h"

@class DBCompany, DBFeedback;

@interface DBProduct : RKManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * product_id;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSNumber * upc;
@property (nonatomic, retain) NSString * logo_path;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * company_id;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) DBCompany * company;
@property (nonatomic, retain) NSSet * feedbacks;

- (NSString*) getImagePath;
    
@end
