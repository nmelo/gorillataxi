//
//  ImageDownloader.m
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/17/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import "ImageDownloader.h"
#import "JSON.h"
#import "QSStrings.h"


@implementation ImageDownloader

@synthesize delegate;
@synthesize indexPath;
@synthesize productId;
@synthesize image;
@synthesize activeDownload;
@synthesize imageConnection;

- (void)startDownload {
	self.activeDownload = [NSMutableData data];

	NSString *url = [NSString stringWithFormat:@"http://democrathings2.heroku.com/products/%@/get_image.json", self.productId];

	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: url]];
	
	[request setHTTPMethod: @"GET"];
	[request addValue:@"Basic Zm9vOmJhcg==" forHTTPHeaderField:@"Authorization"];	
	[request addValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-type"];	
	[request addValue:@"Keep-Alive" forHTTPHeaderField:@"Connection"];	

	NSURLConnection * conn = [NSURLConnection connectionWithRequest:request delegate:self];
	
	self.imageConnection = conn;
}

- (void)cancelDownload {
	[self.imageConnection cancel];

	self.imageConnection = nil;
	self.activeDownload = nil;	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[self.activeDownload appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// Clear the activeDownload property to allow later attempts
	self.activeDownload = nil;

	// Release the connection now that it's finished
	self.imageConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// get the image
	NSString *returnString = [[NSString alloc] initWithData:self.activeDownload encoding: NSUTF8StringEncoding];
	
	NSDictionary *dict = [NSDictionary alloc];
	dict = [returnString JSONValue];
	
	if ([dict objectForKey:@"product"] != nil) {
		NSDictionary *json = [dict objectForKey:@"product"];
		
		if ([json objectForKey:@"binary_data_base64"] != nil) {
			NSString *dataString = [json objectForKey:@"binary_data_base64"];
			NSData *decodedData = [QSStrings decodeBase64WithString:dataString];
			
			self.image = [[UIImage alloc] initWithData:decodedData];
		}
	}
	
	// clear temporary data/image
	self.activeDownload = nil;
	
	// Release the connection now that it's finished
	self.imageConnection = nil;

	// call our delegate and tell it that our icon is ready for display
	[delegate imageDidLoad:self.indexPath];
}

- (void)dealloc {
	[indexPath release];
	[productId release];
	[image release];
	[imageConnection cancel];
	[imageConnection release];	
	
	[super dealloc];
}

@end
