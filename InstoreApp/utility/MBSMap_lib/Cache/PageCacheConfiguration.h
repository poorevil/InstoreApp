//
//  PageCacheConfiguration.h
//  SmartMall
//
//  Created by sunyifei on 1/8/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import "CacheConfiguration.h"

@interface CacheFileObject : NSObject {
    
}

@property (nonatomic, retain) NSString *cacheFileName;
@property (nonatomic, retain) NSData *cacheData;
@property (nonatomic) BOOL needEncrypt;

@end

@interface CacheNameObject : NSObject {
    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *timeStamp;

@end


@interface PageCacheConfiguration : NSObject {
    BOOL cacheTrimmed;
}

@property (nonatomic, retain) CacheConfiguration *cacheConfig;
@property (nonatomic, retain) NSString *cachePath;

+ (PageCacheConfiguration *)getInstance;
- (void)trimCache;
- (void)touchFile:(NSString*)path;
- (BOOL)pageExistsForName:(NSString *)fileName;

- (NSData*)loadPageFromCache:(NSString*) pageName;
- (NSData*)loadPageFromOldCache:(NSString*) pageName;
- (NSData*)loadDecodedPageFromCache:(NSString*)pageName;

- (BOOL)savePage:(NSData*)pageData toCacheWithName:(NSString*)pageName encrypt:(BOOL)needEncrypt;

- (BOOL)deletePage:(NSString*)pageName;
- (BOOL)deleteOldPage:(NSString*)pageName;

- (void)threadSaveData:(NSData*)data withName:(NSString *)fileName needEncrypt:(BOOL)needEncrypt;
- (void)saveCacheSTWithServerTS:(NSString *)serverTS andClientTS:(NSString *)clientTS forPageFileName:(NSString*)pageFileName;

@end
