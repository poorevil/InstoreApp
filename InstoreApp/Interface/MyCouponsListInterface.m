//
//  MyCouponsListInterface.m
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyCouponsListInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation MyCouponsListInterface

-(void)getMyCouponsList
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/coupons_focus",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    "totalCount":<总页数>,
//    "currentPage":<当前页>,
//    "coupons":[                         //优惠列表
//               {store:                         // 优惠对应的商户信息
//                   {
//                   title: '商户名称',
//                   logo: '商户LOGO',
//                       id: '商户ID',              // **int**
//                   category: {
//                       id: '商户类型ID',        // **int**
//                   name: '商户类型名称'
//                   }
//                   },
//                   id: '优惠ID',                // **int**
//               title: '优惠标题',
//               type: '优惠类型',              // **int** 1: 优惠活动; 2: 优惠券; 3: 团购;
//               hotTag: '优惠HOT标签',
//               image: '优惠图',
//               collectCount: '下载数',        // **int**
//               commentCount: '评论数',        // **int**
//               focusCount: '关注数',          // **int**
//               startTime: '开始时间',
//               endTime: '结束时间'
//               }
//               ...
//               ]
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
        
        if ([self.delegate respondsToSelector:@selector(getMyCouponsListDidFinished:totalAmount:currentPage:)]) {
            [self.delegate getMyCouponsListDidFinished:resultList
                                        totalAmount:totalCount
                                        currentPage:currentPage];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getMyCouponsListDidFailed:)]) {
        [self.delegate getMyCouponsListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}


@end
