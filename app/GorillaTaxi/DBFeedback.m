//
//  DBFeedback.m
//  Frankly
//
//  Created by Nelson Melo on 4/29/11.
//  Copyright 2011 nmelolabs.com. All rights reserved.
//

#include "DBFeedback.h"

@implementation DBFeedback

@dynamic feedback_type;
@dynamic user_id;
@dynamic entity_type;
@dynamic entity_name;
@dynamic content;
@dynamic created_at;
@dynamic updated_at;
@dynamic product_id;
@dynamic feedback_id;
@dynamic user;
@dynamic votes;
@dynamic product;
@dynamic owned_by_me;
@dynamic company_id;
@dynamic company;
@dynamic positive_vote_count;
@dynamic negative_vote_count;

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
            @"android_user_id", @"user_id", 
            @"created_at", @"created_at", 
            @"updated_at", @"updated_at", 
            @"id", @"feedback_id", 
            @"content", @"content", 
            @"feedbackable_type", @"entity_type",
            @"feedback_type_id", @"feedback_type",
            @"positive_vote_count", @"positive_vote_count",
            @"negative_vote_count", @"negative_vote_count",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"feedback_id";
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
            @"user", @"user_id",
			nil];
}

+ (NSDictionary*)elementToRelationshipMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"user", @"user",
            nil];
}

@end