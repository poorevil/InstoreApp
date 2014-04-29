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
                  @"order":order,
                  @"amount":[NSString stringWithFormat:@"%d",amount],
                  @"pageNum":[NSString stringWithFormat:@"%d",pageNum]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    
//    "coupons": [
//                {
//                    "startTime": 1398703339205,
//                    "id": 1,
//                    "collectCount": 11,
//                    "title": "测试优惠活动",
//                    "store": {
//                        "id": 1,
//                        "logo": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//                        "category": 1,
//                        "title": "商户名称"
//                    },
//                    "tag": "HOT",
//                    "image": "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//                    "endTime": 1398703339205,
//                    "commentCount": 11,
//                    "type": 1
//                },
//                ...
//                ],
//    "totalCount": 3,
//    "currentPage": 1
//    
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSMutableArray *resultList = [NSMutableArray array];
        NSInteger totalCount = 0;
        NSInteger currentPage = 0;
        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            
            NSArray *couponsArray = [jsonObj objectForKey:@"coupons"];
            if (couponsArray) {
                for (NSDictionary *couponDict in couponsArray) {
                    CouponModel *coupon = [[CouponModel alloc] initWithJsonMap:couponDict];
                    [resultList addObject:coupon];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(searchDidFinished:totalAmount:currentPage:)]) {
            [self.delegate searchDidFinished:resultList
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


@end
