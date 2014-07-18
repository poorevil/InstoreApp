//
//  DownloadCouponModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//


//获得已下载的优惠券列表

#import <Foundation/Foundation.h>
#import "StoreModel.h"

@interface DownloadCouponModel : NSObject

@property (assign, nonatomic) NSInteger cid;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *instruction;
@property (retain, nonatomic) NSString *couponCode;
@property (assign, nonatomic) NSInteger couponStatus;  // 优惠券状态 <0, "未消费/正常">, <1, "已消费">, <3, "已过期">;
@property (retain, nonatomic) NSDate *startTime;
@property (retain, nonatomic) NSDate *endTime;
@property (retain, nonatomic) NSString *imageURL;
@property (retain, nonatomic) StoreModel *storeModel;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
