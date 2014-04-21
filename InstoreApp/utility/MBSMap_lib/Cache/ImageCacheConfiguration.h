//
//  ImageCacheConfiguration.h
//  SmartMall
//
//  Created by sunyifei on 1/8/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import "CacheConfiguration.h"

@interface ImageCacheConfiguration : NSObject {
    BOOL cacheTrimmed;
}

@property (nonatomic, retain) CacheConfiguration *cacheConfig;
@property (nonatomic, retain) NSString *cachePath;

+ (ImageCacheConfiguration *)getInstance;
- (void)trimCache;
- (void)touchFile:(NSString*)path;
- (UIImage*)loadImageFromCache:(NSString*) url;
- (BOOL)saveImage:(NSData*)imageData toCacheWithName:(NSString*)url;
@end
