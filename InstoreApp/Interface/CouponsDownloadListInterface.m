//
//  CouponsDownloadListInterface.m
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponsDownloadListInterface.h"
#import "CouponModel.h"
#import "JSONKit.h"

@implementation CouponsDownloadListInterface

-(void)getCouponsDownloadList
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/coupons_download",BASE_INTERFACE_DOMAIN, MALL_CODE];
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
//                   id: '优惠ID',                 // **int**
//               title: '优惠标题',
//               coupon_code: '优惠券代码',
//               coupon_status: '优惠券状态',   // **int** ('0', '未消费'), ('1', '已消费')
//               startTime: '开始时间',
//               endTime: '结束时间'
//               }
//               ]
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
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
        
        if ([self.delegate respondsToSelector:@selector(getCouponsDownloadListDidFinished:totalAmount:currentPage:)]) {
            [self.delegate getCouponsDownloadListDidFinished:resultList
                                                 totalAmount:totalCount
                                                 currentPage:currentPage];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCouponsDownloadListFailed:)]) {
        [self.delegate getCouponsDownloadListFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}
@end
