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
//                  @"order":order,
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
//                    store:                         // 优惠对应的商户信息
//                        {
//                        title: '商户名称',
//                        logo: '商户LOGO',
//                            id: '商户ID',               // **int**
//                        category: {
//                            id: '商户类型ID',        // **int**
//                        name: '商户类型名称'
//                        }
//                        },
//                        id: '优惠ID',                  // **int**
//                        title: '优惠标题',
//                        type: '优惠类型',              // **int** 1: 优惠活动; 2: 优惠券; 3: 团购;
//                        hotTag: '优惠HOT标签',
//                        isFocus: '是否已关注',         // **boolean** true: 已关注; false: 未关注
//                        image: '优惠图',
//                        pixelWith: '图片宽',            // **int**
//                        pixelHeight: '图片高',          // **int**
//                        collectCount: '下载数',        // **int**
//                        commentCount: '评论数',        // **int**
//                        focusCount: '关注数',          // **int**
//                        startTime: '开始时间',
//                        endTime: '结束时间'
//                },
//                ...
//                ],
//    "totalCount": 3,
//    "currentPage": 1
//
//}
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
            
            NSArray *couponsArray = [jsonObj objectForKey:@"coupons"];
            if (couponsArray) {
                for (NSDictionary *couponDict in couponsArray) {
                    CouponModel *coupon = [[[CouponModel alloc] initWithJsonMap:couponDict] autorelease];
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

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}


@end
