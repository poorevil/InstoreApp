//
//  DownloadCouponDetailInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-30.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DownloadCouponDetailInterface.h"
#import "JSONKit.h"

@implementation DownloadCouponDetailInterface

-(void)getMyDownloadCouponDetailWithID:(NSInteger)cid{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/promotion/download/%d"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE,cid];
    self.baseDelegate = self;
    [self connect];
}
#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Promotion-Detail
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];

    
    if (jsonObj) {
        NSDictionary *dict = (NSDictionary *)jsonObj;
        DownloadCouponModel *model = [[DownloadCouponModel alloc]initWithJsonMap:dict];
        if (_delegate && [_delegate respondsToSelector:@selector(getMyDownloadCouponDetailDidFinished:)]) {
            [_delegate getMyDownloadCouponDetailDidFinished:model];
        }
        [model release];
    }else{
        if (_delegate &&[_delegate respondsToSelector:@selector(getMyDownloadCouponDetailDidFailed:)]) {
            [_delegate getMyDownloadCouponDetailDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getMyDownloadCouponDetailDidFailed:)]) {
        [self.delegate getMyDownloadCouponDetailDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}


@end
