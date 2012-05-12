//
//  JSONHelper.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/12/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "JSONHelper.h"
#import "JSON.h"


NSString* const SERVER_URL = @"http://democrathings2.heroku.com/";


@implementation JSONHelper

+ (NSString *) addUser:(NSDictionary *) userValues {
	NSString *userId = nil;
	
	NSString *url = [NSString stringWithFormat:@"%@android_users.json", SERVER_URL];
	
	NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys: userValues, @"android_user", nil];
	NSString *requestString = [NSString stringWithFormat:@"%@", [json JSONFragment], nil];
	NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
	
	[request setHTTPMethod: @"POST"];
	[request addValue:@"Basic Zm9vOmJhcg==" forHTTPHeaderField:@"Authorization"];	
	[request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];	
	[request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];	
	[request setHTTPBody: requestData];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];

	// decoding the json
	NSDictionary *dict = [NSDictionary alloc];
	
	dict = [returnString JSONValue];
	
	if ([dict objectForKey:@"android_user"] != nil) {
		NSDictionary *json = [dict objectForKey:@"android_user"];
		
		if ([json objectForKey:@"id"] != nil) {
			userId = [json objectForKey:@"id"];
		}
	}
	
	return userId;
}

+ (NSString *) getUserId:(NSString *) facebookId {
	NSString *userId = nil;
	
	NSString *url = [NSString stringWithFormat:@"%@android_users/get_by_facebook_id.json", SERVER_URL];
	
	NSDictionary *facebookDict = [NSDictionary dictionaryWithObjectsAndKeys:facebookId, @"facebook_id", nil];
	NSString *requestString = [NSString stringWithFormat:@"%@", [facebookDict JSONFragment], nil];
	NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
	
	[request setHTTPMethod: @"POST"];
	[request addValue:@"Basic Zm9vOmJhcg==" forHTTPHeaderField:@"Authorization"];	
	[request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];	
	[request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];	
	[request setHTTPBody: requestData];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
	
	// decoding the json
	NSDictionary *dict = [NSDictionary alloc];
	
	dict = [returnString JSONValue];
	
	if ([dict objectForKey:@"android_user"] != nil) {
		NSDictionary *json = [dict objectForKey:@"android_user"];
		
		if ([json objectForKey:@"id"] != nil) {
			userId = [json objectForKey:@"id"];
		}
	}
	
	return userId;
}

+ (NSString *) addCompany:(NSDictionary *) companyValues {
	NSString *companyId = nil;
	
	NSString *url = [NSString stringWithFormat:@"%@companies.json", SERVER_URL];
	
	NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys: companyValues, @"company", nil];
	NSString *requestString = [NSString stringWithFormat:@"%@", [json JSONFragment], nil];
	NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
	
	[request setHTTPMethod: @"POST"];
	[request addValue:@"Basic Zm9vOmJhcg==" forHTTPHeaderField:@"Authorization"];	
	[request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];	
	[request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];	
	[request setHTTPBody: requestData];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
	
	// decoding the json
	NSDictionary *dict = [NSDictionary alloc];
	
	dict = [returnString JSONValue];
	
	if ([dict objectForKey:@"id"] != nil) {
		companyId = [dict objectForKey:@"id"];
	}
	
	return companyId;
}

+ (NSString *) getCompanyId:(NSString *) name {
	NSString *companyId = nil;
	
	NSString *escapedString = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *url = [NSString stringWithFormat:@"%@companies/get_by_name.json?name=%@", SERVER_URL, escapedString];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
	
	[request setHTTPMethod: @"GET"];
	[request addValue:@"Basic Zm9vOmJhcg==" forHTTPHeaderField:@"Authorization"];	
	[request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];	
	[request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];	
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
	
	// decoding the json
	NSDictionary *dict = [NSDictionary alloc];
	dict = [returnString JSONValue];
	
	NSString *null = [NSString stringWithFormat: @"null"];
	NSString *value = [dict objectForKey:@"company"];
	
	if (![null isEqualToString:value]) {
		companyId = [dict objectForKey:@"id"];
	}
	
	return companyId;
}

+ (NSString *) addProduct:(NSDictionary *) productValues {
	NSString *productId = nil;
	
	NSString *url = [NSString stringWithFormat:@"%@products.json", SERVER_URL];
	
	NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys: productValues, @"product", nil];
	NSString *requestString = [NSString stringWithFormat:@"%@", [json JSONFragment], nil];
	NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
	
	[request setHTTPMethod: @"POST"];
	[request addValue:@"Basic Zm9vOmJhcg==" forHTTPHeaderField:@"Authorization"];	
	[request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];	
	[request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];	
	[request setHTTPBody: requestData];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
	
	// decoding the json
	NSDictionary *dict = [NSDictionary alloc];
	
	dict = [returnString JSONValue];
	
	if ([dict objectForKey:@"id"] != nil) {
		productId = [dict objectForKey:@"id"];
	}
	
	return productId;
}

+(NSDictionary* ) getProducts:(NSString *)name {
	NSString *escapedString = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *url = [NSString stringWithFormat:@"%@products/search.json?name=%@", SERVER_URL, escapedString];
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
	
	[request setHTTPMethod: @"GET"];
	[request addValue:@"Basic Zm9vOmJhcg==" forHTTPHeaderField:@"Authorization"];	
	[request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];	
	[request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];	
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
	
	// decoding the json
	NSDictionary *dict = [NSDictionary alloc];
	dict = [returnString JSONValue];
	
	return dict;
}

+ (NSString *) addFeedback:(NSDictionary *) feedbackValues {
	NSString *feedbackId = nil;
	
	NSString *url = [NSString stringWithFormat:@"%@feedbacks.json", SERVER_URL];
	
	NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys: feedbackValues, @"feedback", nil];
	NSString *requestString = [NSString stringWithFormat:@"%@", [json JSONFragment], nil];
	NSData *requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
	
	[request setHTTPMethod: @"POST"];
	[request addValue:@"Basic Zm9vOmJhcg==" forHTTPHeaderField:@"Authorization"];	
	[request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];	
	[request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];	
	[request setHTTPBody: requestData];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
	
	// decoding the json
	NSDictionary *dict = [NSDictionary alloc];
	
	dict = [returnString JSONValue];
	
	if ([dict objectForKey:@"id"] != nil) {
		feedbackId = [dict objectForKey:@"id"];
	}
	
	return feedbackId;
}

@end
