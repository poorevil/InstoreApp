//
//  DailyDealInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DailyDealInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation DailyDealInterface

-(void)getDailyDealByPage:(NSInteger)page amount:(NSInteger)amount{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/daily_promotion"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Daily-Promotion
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = 0;
        NSInteger currentPage = 0;
        NSMutableArray *resultList = [NSMutableArray array];
        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            
            NSArray *dailyListArray = [jsonObj objectForKey:@"list"];
            if (dailyListArray) {
                for (NSDictionary *dailyList in dailyListArray) {
                    CouponModel *couponModel = [[CouponModel alloc]initWithJsonMap:dailyList];
                    [resultList addObject:couponModel];
                    [couponModel release];
                }
            }
        }
        if ([self.delegate respondsToSelector:@selector(getDailyDealDidFinished:totalCount:currentPage:)]) {
            [self.delegate getDailyDealDidFinished:resultList
                                       totalCount:totalCount
                                      currentPage:currentPage];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(getDailyDealDidFailed:)]) {
            [self.delegate getDailyDealDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getDailyDealDidFailed:)]) {
        [self.delegate getDailyDealDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}

@end
