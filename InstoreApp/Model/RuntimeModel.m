//
//  RuntimeModel.m
//  InstoreApp
//
//  Created by evil on 14-4-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "RuntimeModel.h"
#import "KeyChainTool.h"

@implementation RuntimeModel

//{
//
//    "appName": "光耀东方",
//    "secretKey": null,
//    "mallCode": "bj001",
//    "mallLogo": "http://localhost:8000/admin/api/mall/add/",
//    "mallMapId": "123",
//    "mallId": 1,
//    "date": 1398697122064,
//    "isNewUser": 0,
//    "mallName": "光耀东方"
//
//}
-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.appName = [jsonMap objectForKey:@"appName"];
            self.secretKey = [jsonMap objectForKey:@"secretKey"];
            self.mallCode = [jsonMap objectForKey:@"mallCode"];
            self.mallLogo = [jsonMap objectForKey:@"mallLogo"];
            self.mallMapId = [jsonMap objectForKey:@"mallMapId"];
            self.mallId = [[jsonMap objectForKey:@"mallId"] integerValue];
            self.date = [NSDate dateWithTimeIntervalSince1970:[[jsonMap objectForKey:@"date"] longValue]];
            self.isNewUser = [[jsonMap objectForKey:@"isNewUser"] integerValue];
            self.mallName = [jsonMap objectForKey:@"mallName"];
        }
    }
    
    return self;
}

-(void)setSecretKey:(NSString *)secretKey
{
    if (secretKey) {
        [KeyChainTool setValue:secretKey forKey:@"secretKey"];
    }

}

-(NSString *)secretKey
{
    return [KeyChainTool getValueByKey:@"secretKey"];
}

@end
