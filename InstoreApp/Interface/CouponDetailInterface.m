//
//  CouponDetailInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDetailInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation CouponDetailInterface

-(void)getCouponDetailByCouponId:(NSInteger)cid{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon_detail",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"couponid":[NSString stringWithFormat:@"%d",cid]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    
//    "collectCount": 11,
//    "store": {
//        "storeNo": "M431",
//        "id": 1,
//        "logo": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//        "category": 1,
//        "title": "商户名称",
//        "floor": "5",
//        "address": "羊坊店路18号光耀东方N座907",
//        "mapid": "map123",
//        "tel": "111111"
//    },
//    "tag": "HOT",
//    "downloadCount": 2,
//    "endTime": 1399220371943,
//    "type": 1,
//    "commentCount": 11,
//    "date": 1399220371943,
//    "id": 1,
//    "startTime": 1399220371943,
//    "title": "测试优惠活动",
//    "description": "description",
//    "images": [
//               "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//               "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//               "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//               "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg"
//               ],
//    "downloadLimit": -2
//    
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        CouponModel *coupon = nil;
        if (jsonObj) {
            coupon = [[CouponModel alloc] initWithJsonMap:jsonObj];
        }
        
        if ([self.delegate respondsToSelector:@selector(getCouponDetailDidFinished:)]) {
            [self.delegate getCouponDetailDidFinished:coupon];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCouponDetailDidFailed:)]) {
        [self.delegate getCouponDetailDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}


@end
