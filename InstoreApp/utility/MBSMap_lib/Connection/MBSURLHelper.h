//
//  URLHelper.h
//  SmartMall
//
//  Created by dujianping on 11/11/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kstrServerState;

@interface MBSURLHelper : NSObject {
    
}

//svg shapes
+(NSString *)getIconURLwithType:(NSString *)t;
+(NSString *)getFloorsURLfromId:(int)mallId;
+(NSString *)getFloors2URLfromId:(int)mallId;
+(NSString *)getMapURLfromMallId:(int)mallId fromFloorId:(int)floorId;

//getlist
+(NSString *)getCityListUrl;
+(NSString *)getMallsUrlWithCityCode:(NSString*)cityCode;
+(NSString *)getMallStoresUrl:(NSInteger)mallId withCityCode:(NSString*)cityCode;
+(NSString *)getSpacesUrlWithCityCodeAndSpaceType:(NSString*)cityCode 
                                    withSpaceType:(NSInteger)spaceType;

//getDetail
+(NSString *)getMallDetailUrl:(NSInteger)mallId withCityCode:(NSString *)cityCode;
+(NSString *)getStoreDetailUrl:(long long)storeId withCityCode:(NSString *)cityCode;
//version
+(NSString *)getServerStateUrl;
+(NSString *)getUserAgent;

@end
