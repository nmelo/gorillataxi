//
//  ImageDownloader.h
//  MobileFeedback
//
//  Created by Ralph Tavarez on 4/17/11.
//  Copyright 2011 Hollowire Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ImageDownloaderDelegate;


@interface ImageDownloader : NSObject {
	id <ImageDownloaderDelegate>	delegate;
	NSIndexPath						*indexPath;
	NSString						*productId;
	UIImage							*image;
	NSMutableData					*activeDownload;
	NSURLConnection					*imageConnection;
}

@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;


- (void)startDownload;
- (void)cancelDownload;

@end

@protocol ImageDownloaderDelegate 

- (void)imageDidLoad:(NSIndexPath *)indexPath;

@end