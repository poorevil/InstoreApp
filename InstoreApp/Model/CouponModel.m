//
//  CouponModel.m
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponModel.h"
#import "StoreModel.h"

@implementation CouponModel

//{
//    "startTime": 1398703339205,
//    "id": 1,
//    "collectCount": 11,
//    "title": "测试优惠活动",
//    "store": {
//        "id": 1,
//        "logo": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//        "category": 1,
//        "title": "商户名称"
//    },
//    "tag": "HOT",
//    "image": "http://img10.360buyimg.com/da/g14/M0A/1F/11/rBEhVVNXWkEIAAAAAAEZiA2IHjIAAMfMQFTwKkAARmg289.jpg",
//    "endTime": 1398703339205,
//    "commentCount": 11,
//    "type": 1
//},


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
//    "downloadLimit": -2
//
//}
-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.startTime = [NSDate dateWithTimeIntervalSince1970:[[jsonMap objectForKey:@"startTime"] longValue]];
            self.endTime = [NSDate dateWithTimeIntervalSince1970:[[jsonMap objectForKey:@"endTime"] longValue]];
            self.cid = [[jsonMap objectForKey:@"id"] integerValue];
            self.collectCount = [[jsonMap objectForKey:@"collectCount"] integerValue];
            self.title = [jsonMap objectForKey:@"title"];
            self.tag = [jsonMap objectForKey:@"tag"];
            self.imageUrl = [jsonMap objectForKey:@"image"];
            self.commentCount = [[jsonMap objectForKey:@"commentCount"] integerValue];
            self.type = [[jsonMap objectForKey:@"type"] integerValue];
            
            self.downloadCount = [jsonMap objectForKey:@"downloadCount"]==nil?0:[[jsonMap objectForKey:@"downloadCount"] integerValue];
            self.date = [jsonMap objectForKey:@"date"]==nil?nil:[NSDate dateWithTimeIntervalSince1970:[[jsonMap objectForKey:@"date"] longValue]];
            self.descriptionStr = [jsonMap objectForKey:@"description"];
            self.downloadLimit = [jsonMap objectForKey:@"downloadLimit"]==nil?0:[[jsonMap objectForKey:@"downloadLimit"] integerValue];
            
            self.images = [jsonMap objectForKey:@"images"]==nil?[NSMutableArray array]:[NSMutableArray arrayWithArray:[jsonMap objectForKey:@"images"]];
               
            self.store = [[StoreModel alloc] initWithJsonMap:[jsonMap objectForKey:@"store"]];
        }
    }
    
    return self;
}

@end
