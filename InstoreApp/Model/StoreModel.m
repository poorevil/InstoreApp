//
//  StoreModel.m
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel
//{
//    "id": 1,
//    "logo": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//    "category": 1,
//    "title": "商户名称"
//}
-(id)initWithJsonMap:(NSDictionary*)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.sid = [jsonMap objectForKey:@"id"];
            self.logoUrl = [jsonMap objectForKey:@"logo"];
            self.categoryId = [jsonMap objectForKey:@"category"];
            self.title = [jsonMap objectForKey:@"title"];
        }
    }
    
    return self;
}

@end
