//
//  TimeStamp.h
//  SmartMall
//
//  Created by Zhang Jie on 11-11-18.
//  Copyright (c) 2011年 __www.widitu.net__. All rights reserved.
//
#define kTimeStampPlist @"timestamp"

#define kMainCacheName @"MainCache"
#define kBrandDetail @"brandDetailCache"
#define kCategary @"categaryCache"
#define kCity @"cityCache"
#define kMallMore @"mallMoreCache"
#define kMallsLayout @"mallsLayout"
#define kMallsListview @"mallsListview"
#define kMallStores @"mallStores"
#define kStoreOverview @"storeOverview"

#import <Foundation/Foundation.h>

@interface TimeStamp : NSObject

+(NSString*)timeStampPath;
+(void)updataStampTime:(NSString*)cacheName withServerTS:(NSString*)serverTS andClientTS:(NSString*)clientTS;
+(void)removeStampTimeForFile:(NSString*)cacheName;
+(NSString*)strTimeStampWithCacheName:(NSString*)cacheName;
+(void)writeToFile;

//for test
+(void)PrintfFileNamesInFileDict;
@end
