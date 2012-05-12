//
//  DBVote.h
//  Frankly
//
//  Created by Nelson Melo on 4/26/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData/CoreData.h>

@class DBFeedback, DBUser;

@interface DBVote : RKManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSNumber * feedback_id;
@property (nonatomic, retain) NSNumber * didLike;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSNumber * vote_id;
@property (nonatomic, retain) DBUser * user;

@end
