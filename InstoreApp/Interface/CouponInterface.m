//
//  CouponInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-4.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation CouponInterface

-(void)getCouponListByCid:(NSString *)cid
                   isLike:(NSInteger)isLike
                    order:(NSString *)order
                   amount:(NSInteger)amount
                     page:(NSInteger)pageNum
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"cid":cid,
//                  @"order":order,
                  @"like":[NSString stringWithFormat:@"%d",isLike],
                  @"amount":[NSString stringWithFormat:@"%d",amount],
                  @"page":[NSString stringWithFormat:@"%d",pageNum]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    
//    "coupons": [
//                {
//                    "startTime": 1399219706324,
//                    "id": 1,
//                    "collectCount": 11,
//                    "title": "测试优惠活动",
//                    "store": {
//                        "id": 1,
//                        "logo": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//                        "category": 1,
//                        "title": "测试优惠活动"
//                    },
//                    "tag": "HOT",
//                    "image": "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//                    "endTime": 1399219706324,
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
        
        if ([self.delegate respondsToSelector:@selector(getCouponListDidFinished:totalAmount:currentPage:)]) {
            [self.delegate getCouponListDidFinished:resultList
                                 totalAmount:totalCount
                                 currentPage:currentPage];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCouponListDidFailed:)]) {
        [self.delegate getCouponListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}


@end
