//
//  CouponDetailInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDetailInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation CouponDetailInterface

-(void)getCouponDetailByCouponId:(NSInteger)cid{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon_detail",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"couponid":[NSString stringWithFormat:@"%d",cid]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//见文档：https://github.com/joyx-inc/vmall#优惠详细信息接口
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        CouponModel *coupon = nil;
        if (jsonObj) {
            coupon = [[[CouponModel alloc] initWithJsonMap:jsonObj] autorelease];
        }
        
        if ([self.delegate respondsToSelector:@selector(getCouponDetailDidFinished:)]) {
            [self.delegate getCouponDetailDidFinished:coupon];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCouponDetailDidFailed:)]) {
        [self.delegate getCouponDetailDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
