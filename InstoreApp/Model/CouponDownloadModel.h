//
//  CouponDownloadModel.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

//下载优惠券返回的数据模型

#import <Foundation/Foundation.h>

@interface CouponDownloadModel : NSObject

@property (assign, nonatomic) NSInteger status;
@property (retain, nonatomic) NSString *msg;
@property (retain, nonatomic) NSString *couponCode;
@property (retain, nonatomic) NSDate *startTime;
@property (retain, nonatomic) NSDate *endTime;
@property (retain, nonatomic) NSDate *date;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
