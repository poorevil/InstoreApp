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

@implementation StoreModel
//{
//    "id": 1,
//    "logo": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//    "category": 1,
//    "title": "商户名称"
//}
//"store": {
//        "storeNo": "M431",
//        "floor": "5",
//        "address": "羊坊店路18号光耀东方N座907",
//        "mapid": "map123",
//        "tel": "111111"
//    },

-(id)initWithJsonMap:(NSDictionary*)jsonMap
{
    if (self = [super init]) {
        if (jsonMap && ![jsonMap isKindOfClass:[NSNull class]]) {
            self.sid = [[jsonMap objectForKey:@"id"] integerValue];
            self.logoUrl = [jsonMap objectForKey:@"logo"];
            self.categoryModel = [[CategoryModel alloc] initWithJsonMap:[jsonMap objectForKey:@"category"]];
            self.title = [jsonMap objectForKey:@"title"];
            
            self.storeNo = [jsonMap objectForKey:@"storeNo"];
            self.floor = [[FloorModel alloc] initWithJsonMap:[jsonMap objectForKey:@"floor"] areaId:0];
            self.address = [jsonMap objectForKey:@"address"];
            self.mapid = [jsonMap objectForKey:@"mapid"];
            self.tel = [jsonMap objectForKey:@"tel"];
            
            self.followerCount = [jsonMap objectForKey:@"followerCount"]==nil?0:[[jsonMap objectForKey:@"followerCount"] integerValue];
            
            //TODO:
//            coupons;
//            comments;
        }
    }
    
    return self;
}

@end
