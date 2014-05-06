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

-(void)getStoreDetailByShopId:(NSInteger)shopId
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/shop_detail",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"shopid":[NSString stringWithFormat:@"%d",shopId]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{                                       //商户对象
//    <商户对象基本信息>,
//    "coupons":[{商户发布的优惠劵},{商户发布的优惠劵},{商户发布的优惠劵},...],
//    "comments"[{商户的评论信息},{商户的评论信息},{商户的评论信息},...]
//    
//title: '商户名称',
//logo: '商户LOGO',
//    id: '商户ID',
//category: '商户类型',
//floor: '楼层',
//roomNum: '商户房间号',
//description: '介绍',
//followerCount: '关注人数',
//    特殊属性: '特殊属性',
//    特殊属性: '特殊属性',
//    特殊属性: '特殊属性',
//    特殊属性: '特殊属性',
//coupons:[                           // 商户的优惠劵
//         {
//             id: '优惠ID',
//         title: '优惠标题',
//         type: '优惠类型',              // 1: 优惠活动; 2: 优惠券; 3: 团购;
//         tag: '优惠标签',
//         image: '优惠图',
//         }...
//         ],
//comments:[                          // 商户的评论
//          {
//          author: "发布人名字",
//          content: "内容",
//          createTime: "发布时间"
//          },...
//          ]
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        StoreModel *store = nil;
        if (jsonObj) {
            store = [[StoreModel alloc] initWithJsonMap:jsonObj];
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

@end
