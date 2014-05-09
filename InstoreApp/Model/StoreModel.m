//
//  StoreModel.m
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreModel.h"
#import "FloorModel.h"
#import "CategoryModel.h"
#import "CouponModel.h"


@implementation StoreModel
//{                                       //商户对象
//    <商户对象基本信息>,
//    "coupons":[{商户发布的优惠劵},{商户发布的优惠劵},{商户发布的优惠劵},...],
//    "comments"[{商户的评论信息},{商户的评论信息},{商户的评论信息},...]
//
//    id: '商户ID',                    // **int**
//    title: '商户名称',
//    logo: '商户LOGO',
//    category: {
//        id: '商户类型ID',            // **int**
//        name: '商户类型名称'
//    }
//        
//    area: '楼区',
//    floor: '楼层',
//    roomNum: '商户房间号',
//    description: '介绍',
//    followerCount: '关注人数',
//    mapCode: '商户地图ID'
//    coupons:[                           // 商户的优惠劵
//             {
//                 id: '优惠ID',                // **int**
//             title: '优惠标题',
//             type: '优惠类型',             // **int** 1: 优惠活动; 2: 优惠券; 3: 团购;
//             hotTag: '优惠HOT标签',
//             image: '优惠图',
//             }...
//             ],
//    comments:[                          // 商户的评论
//              {
//              author: "发布人名字",
//              content: "内容",
//              createTime: "发布时间"
//              },...
//              ]
//}

-(id)initWithJsonMap:(NSDictionary*)jsonMap
{
    if (self = [super init]) {
        if (jsonMap && ![jsonMap isKindOfClass:[NSNull class]]) {
            self.sid = [[jsonMap objectForKey:@"id"] integerValue];
            self.title = [jsonMap objectForKey:@"title"];
            self.logoUrl = [jsonMap objectForKey:@"logo"];
            self.categoryModel = [[CategoryModel alloc] initWithJsonMap:[jsonMap objectForKey:@"category"]];
            self.area = [jsonMap objectForKey:@"area"];
            self.floor = [[FloorModel alloc] init];
            self.floor.fName = [jsonMap objectForKey:@"floor"];
            self.roomNum = [jsonMap objectForKey:@"roomNum"];
            self.descStr = [jsonMap objectForKey:@"description"];
            self.followerCount = [jsonMap objectForKey:@"followerCount"]==nil?0:[[jsonMap objectForKey:@"followerCount"] integerValue];
            self.mapCode = [jsonMap objectForKey:@"mapCode"];
            
            self.coupons = [NSMutableArray array];
            NSArray *coupons = [jsonMap objectForKey:@"coupons"];
            for (NSDictionary *couponDict in coupons) {
                [self.coupons addObject:[[CouponModel alloc] initWithJsonMap:couponDict]];
            }
            
            //TODO:
//            coupons;
//            comments;
        }
    }
    
    return self;
}

@end
