//
//  CouponModel.m
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponModel.h"
#import "StoreModel.h"
#import "NSDate+DynamicDateString.h"

@implementation CouponModel

//{
//
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

//    "downloadCount": 2,
//    "date": 1399220371943,
//    "description": "description",
//    "images": [
//               "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//               "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//               "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//               "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg"
//               ],
//    "downloadLimit": -2,
//    collectType: '下载方式'            // 0: 免费下, 1: 分享后下载
//    collectLimit: '限量'              // 0: 不限制; N: 限制下载N次,
//    collectRole: '下载规则'            // 待定, 目前返回空串,统一处理为每人限下载一次
//    userCollectCount: '我的下载次数',       // 根据role不同会有不同的处理情况,目前总是返回1.


//{
//        store:                         // 优惠对应的商户信息
//            {
//                title: '商户名称',
//                logo: '商户LOGO',
//                id: '商户ID',               // **int**
//                category: {
//                      id: '商户类型ID',        // **int**
//                      name: '商户类型名称'
//                }
//            },
//        id: '优惠ID',                  // **int**
//        title: '优惠标题',
//        type: '优惠类型',              // **int** 1: 优惠活动; 2: 优惠券; 3: 团购;
//        hotTag: '优惠HOT标签',
//        isFocus: '是否已关注',         // **boolean** true: 已关注; false: 未关注
//        image: '优惠图',
//        pixelWith: '图片宽',            // **int**
//        pixelHeight: '图片高',          // **int**
//        collectCount: '下载数',        // **int**
//        commentCount: '评论数',        // **int**
//        focusCount: '关注数',          // **int**
//        startTime: '开始时间',
//        endTime: '结束时间'
//},
-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.startTime = [NSDate dateFromString:[jsonMap objectForKey:@"startTime"]];
            self.endTime = [NSDate dateFromString:[jsonMap objectForKey:@"endTime"]];
            self.cid = [[jsonMap objectForKey:@"id"] integerValue];
            self.collectCount = [jsonMap objectForKey:@"collectCount"]?[[jsonMap objectForKey:@"collectCount"] integerValue]:0;
            self.title = [jsonMap objectForKey:@"title"];
            self.tag = [jsonMap objectForKey:@"tag"];
            self.imageUrl = [jsonMap objectForKey:@"image"];
            self.imageWidth = [jsonMap objectForKey:@"pixelWith"]?[[jsonMap objectForKey:@"pixelWith"] integerValue]:0;
            self.imageHeight = [jsonMap objectForKey:@"pixelHeight"]?[[jsonMap objectForKey:@"pixelHeight"] integerValue]:0;
            self.commentCount = [jsonMap objectForKey:@"commentCount"]?[[jsonMap objectForKey:@"commentCount"] integerValue]:0;
            self.type = [[jsonMap objectForKey:@"type"] integerValue];
            self.hotTag = [jsonMap objectForKey:@"hotTag"];
            self.downloadCount = [jsonMap objectForKey:@"downloadCount"]==nil?0:[[jsonMap objectForKey:@"downloadCount"] integerValue];
            self.date = [jsonMap objectForKey:@"date"]==nil?nil:[NSDate dateFromString:[jsonMap objectForKey:@"date"]];
            self.descriptionStr = [jsonMap objectForKey:@"description"];
            self.downloadLimit = [jsonMap objectForKey:@"downloadLimit"]==nil?0:[[jsonMap objectForKey:@"downloadLimit"] integerValue];
            
            self.instruction = [jsonMap objectForKey:@"instruction"];
            self.focusCount = [jsonMap objectForKey:@"focusCount"]==nil?0:[[jsonMap objectForKey:@"focusCount"] integerValue];
            
            self.images = [jsonMap objectForKey:@"images"]==nil?[NSMutableArray array]:[NSMutableArray arrayWithArray:[jsonMap objectForKey:@"images"]];
            
            self.collectType = [jsonMap objectForKey:@"collectType"]==nil?0:[[jsonMap objectForKey:@"collectType"] integerValue];
            self.collectLimit = [jsonMap objectForKey:@"collectLimit"]==nil?0:[[jsonMap objectForKey:@"collectLimit"] integerValue];
            self.collectRole = [jsonMap objectForKey:@"collectRole"]==[NSNull null]?0:[[jsonMap objectForKey:@"collectRole"] integerValue];
            self.userCollectCount = [jsonMap objectForKey:@"userCollectCount"]==nil?0:[[jsonMap objectForKey:@"userCollectCount"] integerValue];
               
            self.store = [[StoreModel alloc] initWithJsonMap:[jsonMap objectForKey:@"store"]];
            
        }
    }
    
    return self;
}

@end
