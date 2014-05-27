//
//  StoreDetailInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreDetailInterface.h"
#import "JSONKit.h"
#import "StoreModel.h"

@implementation StoreDetailInterface

-(void)getStoreDetailByShopId:(NSInteger)shopId commentSize:(NSInteger)commentSize couponSize:(NSInteger)couponSize
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/shop_detail",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"shopid":[NSString stringWithFormat:@"%d",shopId],
                  @"commentSize":[NSString stringWithFormat:@"%d",commentSize],
                  @"couponSize":[NSString stringWithFormat:@"%d",couponSize]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    
//    "id": 10,
//    "coupons": [
//                {
//                    "id": 191,
//                    "title": "扒者",
//                    "type": 3
//                },
//                {
//                    "id": 171,
//                    "title": "质亡瘴名冀腾本",
//                    "type": 2
//                },
//                {
//                    "id": 155,
//                    "title": "龚伺藏镭伶缮比道认毯",
//                    "type": 1
//                },
//                {
//                    "id": 101,
//                    "title": "黑式",
//                    "hotTag": "HOT",
//                    "type": 3
//                },
//                {
//                    "id": 103,
//                    "title": "鞘帛陌蔚炬狰兔姻碍谴",
//                    "type": 2
//                }
//                ],
//    "logo": "http://storeLogo",
//    "category": {
//        "id": 2,
//        "name": "分类2"
//    },
//    "title": "商户10",
//    "area": "E",
//    "floor": "2",
//    "description": "药鼻庙瓤愚矛慷凯少陶掏抛税链篇...",
//    "roomNum": "8831",
//    "date": "2014-05-09 04:00:39 UTC",
//    "followerCount": 0
//    
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        StoreModel *store = nil;
        if (jsonObj) {
            store = [[[StoreModel alloc] initWithJsonMap:jsonObj] autorelease];
        }
        
        if ([self.delegate respondsToSelector:@selector(getStoreDetailDidFinished:)]) {
            [self.delegate getStoreDetailDidFinished:store];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getStoreDetailDidFailed:)]) {
        [self.delegate getStoreDetailDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
