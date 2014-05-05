//
//  CouponDownInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDownloadInterface.h"
#import "CouponDownloadModel.h"
#import "JSONKit.h"

@implementation CouponDownloadInterface
-(void)getCouponDownloadByCouponId:(NSInteger)couponId
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon_download",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"couponid":[NSString stringWithFormat:@"%d",couponId]};
    self.baseDelegate = self;
    [self connect];
}


#pragma mark - BaseInterfaceDelegate
//{
//status: '下载结果',            // 1: 成功; 2: X; 3: 失败-已下载过; 4: 失败-不符合参与条件
//msg: '提示信息',               // 失败的提示信息
//coupon_code: '优惠代码',              // 1: 优惠活动; 2: 优惠券; 3: 团购;
//    date":"<服务器当前时间>"
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        CouponDownloadModel *couponDownloadModel = nil;
        if (jsonObj) {
            couponDownloadModel = [[CouponDownloadModel alloc] initWithJsonMap:jsonObj];
        }
        
        if ([self.delegate respondsToSelector:@selector(getCouponDownloadDidFinished:)]) {
            [self.delegate getCouponDownloadDidFinished:couponDownloadModel];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCouponDownloadDidFailed:)]) {
        [self.delegate getCouponDownloadDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}
@end
