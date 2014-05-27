//
//  CouponDownloadModel.m
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDownloadModel.h"

@implementation CouponDownloadModel
//{
//status: '下载结果',            // 1: 成功; 2: X; 3: 失败-已下载过; 4: 失败-不符合参与条件
//msg: '提示信息',               // 失败的提示信息
//coupon_code: '优惠代码',              // 1: 优惠活动; 2: 优惠券; 3: 团购;
//    date":"<服务器当前时间>"
//}
-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.status = [[jsonMap objectForKey:@"status"] integerValue];
            self.msg = [jsonMap objectForKey:@"msg"];
            self.couponCode = [[jsonMap objectForKey:@"coupon_code"] integerValue];
        }
    }
    
    return self;
}

-(void)dealloc
{
    self.msg = nil;
    [super dealloc];
}
@end
