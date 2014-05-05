//
//  CouponDownloadModel.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponDownloadModel : NSObject

//{
//status: '下载结果',            // 1: 成功; 2: X; 3: 失败-已下载过; 4: 失败-不符合参与条件
//msg: '提示信息',               // 失败的提示信息
//coupon_code: '优惠代码',              // 1: 优惠活动; 2: 优惠券; 3: 团购;
//    date":"<服务器当前时间>"
//}
@property (nonatomic,assign) NSInteger status;
@property (nonatomic,strong) NSString *msg;
@property (nonatomic,assign) NSInteger couponCode;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
