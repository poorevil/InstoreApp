//
//  ImageDownloader.h
//
//  Created by Jacky on 11-11-11.
//  Copyright 2011年 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageDownloaderDelegate <NSObject>
@required
- (void)imageIsDownloaded:(id)sender withUrl:(NSString*)url; 

@end

@protocol ImageDownloader <NSObject>

@required

- (void)addDownloadImage:(NSString*)url withDelegate:(id<ImageDownloaderDelegate>)delegate; 

- (UIImage*)loadImageFromCache:(NSString*) url; 

// pause image downloader
- (void)pause; 

// resume image downloader
- (void)resume; 

// cancel all image downloading
- (void)cancel; 

@end
