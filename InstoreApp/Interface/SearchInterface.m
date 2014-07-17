//
//  SearchInterface.m
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SearchInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"
#import "StoreModel.h"

@implementation SearchInterface

-(void)searchKeyword:(NSString*) keyword
                type:(NSInteger)type
             orderBy:(NSString *)order
              amount:(NSInteger)amount
                page:(NSInteger)pageNum
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/search",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"keyword":keyword,
                  @"type":[NSString stringWithFormat:@"%d",type],
//                  @"order":order,
                  @"amount":[NSString stringWithFormat:@"%d",amount],
                  @"page":[NSString stringWithFormat:@"%d",pageNum]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate

-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
//        NSMutableArray *resultList = [NSMutableArray array];
        
        NSMutableArray *storeResult = [NSMutableArray array];
        NSArray *storeList = [jsonObj objectForKey:@"store_list"];
        if (storeList) {
            for (NSDictionary *storeDict in storeList) {
                StoreModel *storeModel = [[StoreModel alloc]initWithJsonMap:storeDict];
                [storeResult addObject:storeModel];
                [storeModel release];
            }
        }
        
        [resultDict setObject:storeResult forKey:@"storeList"];
        
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
        NSInteger currentPage = 0;
        if (totalCount > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            
            NSMutableArray *couponResult = [NSMutableArray array];
            NSArray *couponsArray = [jsonObj objectForKey:@"list"];
            if (couponsArray) {
                for (NSDictionary *couponDict in couponsArray) {
                    CouponModel *coupon = [[[CouponModel alloc] initWithJsonMap:couponDict] autorelease];
                    [couponResult addObject:coupon];
                }
            }
            [resultDict setObject:couponResult forKey:@"couponList"];
        }
        
        if ([self.delegate respondsToSelector:@selector(searchDidFinished:totalAmount:currentPage:)]) {
            [self.delegate searchDidFinished:resultDict
                                 totalAmount:totalCount
                                 currentPage:currentPage];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(searchDidFailed:)]) {
        [self.delegate searchDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}


@end
