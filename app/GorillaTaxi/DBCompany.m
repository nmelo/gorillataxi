//
//  DBCompany.m
//  Frankly
//
//  Created by Nelson Melo on 4/26/11.
//  Copyright (c) 2011 nmelolabs.com. All rights reserved.
//

#import "DBCompany.h"

@implementation DBCompany
@dynamic created_at;
@dynamic updated_at;
@dynamic name;
@dynamic company_id;
@dynamic desc;
@dynamic logo_path;
@dynamic products;
@dynamic feedbacks;

+ (NSDictionary*)elementToPropertyMappings {
	return [NSDictionary dictionaryWithKeysAndObjects:
			@"name", @"name",
            @"created_at", @"created_at",
            @"updated_at", @"updated_at",
            @"id", @"company_id",
            @"description", @"desc",
			nil];
}

+ (NSString*)primaryKeyProperty {
	return @"company_id";
}

- (NSString*) getImagePath {
    NSString *imagePath = [NSString stringWithFormat:@"%@/companies/%@/code_image", DBRestKitBaseURL, self.company_id] ;
    return imagePath;
}


@end
