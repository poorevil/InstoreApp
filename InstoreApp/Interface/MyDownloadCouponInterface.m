//
//  MyDownloadCouponInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyDownloadCouponInterface.h"
#import "JSONKit.h"
#import "DownloadCouponModel.h"
#import "StoreModel.h"

@implementation MyDownloadCouponInterface

-(void)getMyDownloadCouponList{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/promotion/download"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.baseDelegate = self;
    [self connect];
}
#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Promotion-Collected
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
        NSInteger currentPage = 0;
        NSMutableArray *resultList = [NSMutableArray array];
        if (totalCount > 0) {
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            NSArray *array = [jsonObj objectForKey:@"list"];
            if (array) {
                for (NSDictionary *dict in array) {
                    DownloadCouponModel *downloadCouponModel = [[DownloadCouponModel alloc]initWithJsonMap:dict];
                    downloadCouponModel.storeModel = [[StoreModel alloc]initWithJsonMap:[dict objectForKey:@"store"]];
                    [resultList addObject:downloadCouponModel];
                }
            }
        }
        if ([self.delegate respondsToSelector:@selector(getMyDownloadCouponListDidFinished:)]) {
            [self.delegate getMyDownloadCouponListDidFinished:resultList];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(getMyDownloadCouponListListDidFailed:)]) {
            [self.delegate getMyDownloadCouponListListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getMyDownloadCouponListListDidFailed:)]) {
        [self.delegate getMyDownloadCouponListListDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}
@end
