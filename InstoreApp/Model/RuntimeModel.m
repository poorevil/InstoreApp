//
//  RuntimeModel.m
//  InstoreApp
//
//  Created by evil on 14-4-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "RuntimeModel.h"
#import "KeyChainTool.h"
#import "NSDate+DynamicDateString.h"

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
            self.mallId = [[jsonMap objectForKey:@"mallId"] integerValue];
            self.mallCode = [jsonMap objectForKey:@"mallCode"];
            self.mallName = [jsonMap objectForKey:@"mallName"];
            self.mallMapId = [jsonMap objectForKey:@"mallMapCode"];
            self.mallLogo = [jsonMap objectForKey:@"mallLogo"];
            self.buildingCount = [jsonMap objectForKey:@"buildingCount"];
            self.appName = [jsonMap objectForKey:@"appName"];
            self.date = [NSDate dateFromString:[jsonMap objectForKey:@"date"]];
            self.isNewUser = [[jsonMap objectForKey:@"isNewUser"] integerValue];
            self.secretKey = [jsonMap objectForKey:@"secretKey"];
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

-(void)dealloc
{
    self.appName = nil;
    self.secretKey = nil;
    self.mallCode = nil;
    self.mallLogo = nil;
    self.mallMapId = nil;
    self.date = nil;
    self.mallName = nil;
    self.buildingCount = nil;
    
    [super dealloc];
}
@end
