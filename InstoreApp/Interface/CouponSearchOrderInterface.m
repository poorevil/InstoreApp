//
//  CouponSearchOrderInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponSearchOrderInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation CouponSearchOrderInterface

-(void)searchByAmount:(NSInteger)amount Page:(NSInteger)page Cid:(NSInteger)cid Type:(NSInteger)type Order:(NSString *)order{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon/search"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"amount":[NSString stringWithFormat:@"%d",amount],
                  @"page":[NSString stringWithFormat:@"%d",page],
                  @"cid": cid == 0 ? @"":[NSString stringWithFormat:@"%d",cid],
                  @"type":type == 0 ? @"":[NSString stringWithFormat:@"%d",type],
                  @"order":order == nil ? @"":order};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Promotion-List
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = 0;
        NSInteger currentPage = 0;
//        NSInteger focusCount = 0;
//        NSInteger pageSize = 0;
        NSMutableArray *resultList = [NSMutableArray array];
        if ([[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
//            focusCount = [[jsonObj objectForKey:@"focusCount"] integerValue];
//            pageSize = [[jsonObj objectForKey:@"pageSize"] integerValue];
            
            NSArray *listArray = [jsonObj objectForKey:@"list"];
            if (listArray) {
                for (NSDictionary *couponDict in listArray) {
                    CouponModel *couponModel = [[CouponModel alloc]initWithJsonMap:couponDict];                    
                    [resultList addObject:couponModel];
                    [couponModel release];
                }
            }
        }
        if ([self.delegate respondsToSelector:@selector(couponSearchOrderDidFinished:totalAmount:currentPage:)]) {
            [self.delegate couponSearchOrderDidFinished:resultList totalAmount:totalCount currentPage:currentPage];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(couponSearchOrderDidFailed:)]) {
            [self.delegate couponSearchOrderDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(couponSearchOrderDidFailed:)]) {
        [self.delegate couponSearchOrderDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}
@end
