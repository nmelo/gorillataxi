//
//  JSONHelper.h
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/12/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JSONHelper : NSObject {

}

+ (NSString *) addUser:(NSDictionary *) userValues;
+ (NSString *) getUserId:(NSString *) facebookId;

+ (NSString *) addCompany:(NSDictionary *) companyValues;
+ (NSString *) getCompanyId:(NSString *) name;

+ (NSString *) addProduct:(NSDictionary *) productValues;
+ (NSDictionary*) getProducts:(NSString *) name;

+ (NSString *) addFeedback:(NSDictionary *) feedbackValues;

@end

