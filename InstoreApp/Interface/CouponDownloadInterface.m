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
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon/download",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"couponid":[NSString stringWithFormat:@"%d",couponId]};
    self.baseDelegate = self;
    [self connect];
}


#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Promotion-Save
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        CouponDownloadModel *couponDownloadModel = nil;
        if (jsonObj) {
            couponDownloadModel = [[[CouponDownloadModel alloc] initWithJsonMap:jsonObj] autorelease];
        }
        
        if ([self.delegate respondsToSelector:@selector(getCouponDownloadDidFinished:)]) {
            [self.delegate getCouponDownloadDidFinished:couponDownloadModel];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(getCouponDownloadDidFailed:)]) {
            [self.delegate getCouponDownloadDidFailed:[NSString stringWithFormat:@"获取失败！"]];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCouponDownloadDidFailed:)]) {
        [self.delegate getCouponDownloadDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}
@end
