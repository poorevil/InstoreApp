//
//  ServiceModel.m
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel
//{
//    "name":"对象名称",
//    "itemType":"对象类型",      //  #1:内置功能; 0: 网页
//    "itemId":"对象id",
//    "picUrl":"图片地址"
//    "link":"链接地址"           // itemType为0的时候才有值
//}
-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.name = [jsonMap objectForKey:@"name"];
            self.itemType = [[jsonMap objectForKey:@"itemType"] integerValue];
            self.sid = [[jsonMap objectForKey:@"itemId"] integerValue];
            self.picUrl = [jsonMap objectForKey:@"picUrl"];
            self.link = [jsonMap objectForKey:@"link"];
        }
    }
    
    return self;
}

@end
