//
//  CacheDataService.h
//  O2O
//
//  Created by Lee Claud on 11-7-5.
//  Copyright 2011年 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadWriteLock.h"

@class CacheConfiguration;

@interface CacheDataService : NSObject{
    ReadWriteLock *lock_;
}

// 按策略清理缓存
- (void)trimCache;

@end
