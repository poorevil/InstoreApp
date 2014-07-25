//
//  CouponSectionTwoInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponSectionTwoInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation CouponSectionTwoInterface

- (void)getCouponSectionTwoListByPage:(NSInteger)page amount:(NSInteger)amount{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon/index2",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Promotion-List
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
//        NSInteger pageSize;
        NSInteger currentPage;
        NSInteger focusCount;
        NSMutableArray *resultArray = [NSMutableArray array];
        if (totalCount) {
//            pageSize = [[jsonObj objectForKey:@"pageSize"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            focusCount = [[jsonObj objectForKey:@"focusCount"] integerValue];
            
            NSArray *listArray = [jsonObj objectForKey:@"list"];
            for (NSDictionary *dict in listArray) {
                CouponModel *couponModel = [[CouponModel alloc]initWithJsonMap:dict];
                [resultArray addObject:couponModel];
                [couponModel release];
            }
            
            if ([self.delegate respondsToSelector:@selector(getCouponSectionTwoListDidFinished:focusCount:totalCount:currentPage:)]) {
                [self.delegate getCouponSectionTwoListDidFinished:resultArray
                                                       focusCount:focusCount
                                                       totalCount:totalCount
                                                      currentPage:currentPage];
            }
        
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(getCouponSectionTwoListDidFailed:)]) {
            [self.delegate getCouponSectionTwoListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCouponSectionTwoListDidFailed:)]) {
        [self.delegate getCouponSectionTwoListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}
@end
