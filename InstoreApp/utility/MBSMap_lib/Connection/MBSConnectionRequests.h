//
//  MBSConnectionRequests.h
//  MBSMapViewController
//
//  Created by sunyifei on 2/12/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataType.h"

@interface MBSRequest : NSObject
- (void)connect;
- (void)cancel;
@end

@interface MBSRequestMalls : MBSRequest
@property (nonatomic) int mallType; //DIANDAO_UNIT_TYPE
- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withCityCode:(NSString *)cityCode;
- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withCityCode:(NSString *)cityCode withMallType:(NSInteger)theMallType;
- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withCityCode:(NSString *)cityCode withMallType:(NSInteger)theMallType withTimeOut:(NSTimeInterval)timeOutSeconds;
@end

@interface MBSRequestStations : MBSRequest

- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withCityCode:(NSString *)cityCode;
- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withCityCode:(NSString *)cityCode withTimeOut:(NSTimeInterval)timeOutSeconds;
@end

@interface MBSRequestCitys : MBSRequest

- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction;
@end

@interface MBSRequestStores : MBSRequest

//sortByName 若为YES，则返回的店铺列表按照店铺名称首字母从a~z排序，并按照首字母分组
//sortByName 若为NO，则返回的店铺列表按照所在楼层从低到高排序
- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withCityCode:(NSString *)cityCode withMallId:(NSInteger)mallId sortedByName:(BOOL)sortByName;
@end

@interface MBSRequestFloors : MBSRequest

- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withMallId:(NSInteger)mallId withImages:(BOOL)fwithImages;
@end

@interface MBSRequestStoreDetail : MBSRequest
- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withStoreId:(long long)storeId withCityCode:(NSString*)cityCode withCache:(BOOL)needCache;
@end