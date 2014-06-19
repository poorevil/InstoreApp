//
//  FoodViewPromotionInterface.m
//  InstoreApp
//
//  Created by evil on 14-6-19.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FoodViewPromotionInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation FoodViewPromotionInterface

-(void)getFoodViewPromotionListByPage:(NSInteger)page amount:(NSInteger)amount
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/restaurant/promotion"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Restaurant-Store
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSMutableArray *resultList = [NSMutableArray array];
        NSInteger totalCount = 0;
        NSInteger currentPage = 0;
        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            
            NSArray *couponArray = [jsonObj objectForKey:@"list"];
            if (couponArray) {
                for (NSDictionary *couponDict in couponArray) {
                    CouponModel *coupon = [[[CouponModel alloc] initWithJsonMap:couponDict] autorelease];
                    [resultList addObject:coupon];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getFoodViewPromotionListDidFinished:totalCount:currentPage:)]) {
            [self.delegate getFoodViewPromotionListDidFinished:resultList
                                                    totalCount:totalCount
                                                   currentPage:currentPage];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(getFoodViewPromotionListDidFailed:)]) {
            [self.delegate getFoodViewPromotionListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getFoodViewPromotionListDidFailed:)]) {
        [self.delegate getFoodViewPromotionListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
