//
//  CacheConfiguration.h
//
//  Created by Jacky on 11-11-11.
//  Copyright 2011年 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CacheConfiguration : NSObject {
    
	BOOL isCounting;
	long fileCount;
	long long byteCount;
    
    NSString* cachePath;
    NSString* countsPath;
    
	long fileCountLimit;
	NSTimeInterval fileAgeLimit;
	NSThread* maintenanceThread;

}

@property long fileCount;
@property long long byteCount;
@property long fileCountLimit;
@property NSTimeInterval fileAgeLimit;
@property (nonatomic, retain) NSThread* maintenanceThread;

- (id)initImageCache;

- (id)initPageCache;

- (void)saveCounts;

- (void)loadCounts;

// 更新缓存文件统计信息（总文件数，总字节数）
- (void)updateCountsAdded:(long)countsAdded andBytesAdded:(long long)bytesAdded;

// 按策略清理缓存
- (void)trimCache;

- (void)trimCacheUsingBackgroundThread;

- (void)trimCacheDir:(NSString*)cachePath;


@end
