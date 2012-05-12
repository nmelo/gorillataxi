//
//  DBFeedback.h
//  Frankly
//
//  Created by Nelson Melo on 4/29/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@class DBCompany, DBProduct, DBUser, DBVote;

typedef enum {
    FeedbackTypeInnovation, 
    FeedbackTypeProblem,
    FeedbackTypeComment,
}  FeedbackType;


@interface DBFeedback: RKManagedObject {
    
}

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * feedback_id;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * entity_type;
@property (nonatomic, retain) NSNumber * product_id;
@property (nonatomic, retain) NSNumber * company_id;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSNumber * feedback_type;
@property (nonatomic, retain) NSString * entity_name;
@property (nonatomic, retain) NSNumber * owned_by_me;
@property (nonatomic, retain) DBProduct * product;
@property (nonatomic, retain) DBCompany * company;
@property (nonatomic, retain) DBUser * user;
@property (nonatomic, retain) NSSet * votes;

@end
