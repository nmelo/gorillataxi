//
//  DBProduct.m
//  Frankly
//
//  Created by Nelson Melo on 4/26/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import "DBProduct.h"

@implementation DBProduct
@dynamic product_id;
@dynamic desc;
@dynamic color;
@dynamic upc;
@dynamic logo_path;
@dynamic name;
@dynamic company_id;
@dynamic created_at;
@dynamic updated_at;
@dynamic company;
@dynamic feedbacks;

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"name", @"name",
            @"created_at", @"created_at",
            @"updated_at", @"updated_at",
            @"id", @"product_id",
            @"color", @"color",
            @"company_id", @"company_id",
            @"upc", @"upc",
            @"description", @"desc",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"product_id";
}

+ (NSDictionary*)relationshipToPrimaryKeyPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"company", @"company_id",
			nil];
}

+ (NSDictionary*)elementToRelationshipMappings {
    return [NSDictionary dictionaryWithKeysAndObjects:
            @"company", @"company",
            nil];
}

- (NSString*) getImagePath {
    NSString *imagePath = [NSString stringWithFormat:@"%@/products/%@/code_image", DBRestKitBaseURL, self.product_id] ;
    return imagePath;
}

@end
