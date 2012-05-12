//
//  DBFeedback.m
//  Frankly
//
//  Created by Nelson Melo on 4/26/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import "DBProductFeedback.h"

@implementation DBProductFeedback

+ (NSDictionary*)elementToPropertyMappings {
    return [super elementToPropertyMappings];
}

+ (NSString*)primaryKeyProperty {
    return [super primaryKeyProperty];
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings {
	return [super relationshipToPrimaryKeyPropertyMappings];
}

+ (NSDictionary*)elementToRelationshipMappings {
    return [super elementToRelationshipMappings];
}

@end

