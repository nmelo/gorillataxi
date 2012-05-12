//
//  DBVote.m
//  Frankly
//
//  Created by Nelson Melo on 4/26/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import "DBVote.h"

@implementation DBVote
@dynamic user_id;
@dynamic feedback_id;
@dynamic didLike;
@dynamic created_at;
@dynamic updated_at;
@dynamic vote_id;
@dynamic user;


+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
            @"android_user_id", @"user_id",
            @"created_at", @"created_at",
            @"updated_at", @"updated_at",
            @"like", @"didLike",
            @"id", @"vote_id",
            @"feedback_id", @"feedback_id",
			nil];
}


+ (NSString*)primaryKeyProperty {
	return @"vote_id";
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
            @"user", @"user_id",
            @"feedback", @"feedback_id",
			nil];
}

+ (NSDictionary*)elementToRelationshipMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"user", @"user",
            @"feedback", @"feedback",
            nil];
}

@end
