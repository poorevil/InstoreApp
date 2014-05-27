//
//  UserInfoModel.m
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

//{
//name: "姓名",
//gender: "性别",            // **int** 0: 保密; 1: 男; 2: 女
//nickName: "昵称",
//mobile: "手机号",
//clubCard: "会员卡号",
//}
-(id)initWithJsonDict:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        self.name = [jsonMap objectForKey:@"name"];
        self.gender = [jsonMap objectForKey:@"gender"];
        self.nickName = [jsonMap objectForKey:@"nickName"];
        self.mobile = [jsonMap objectForKey:@"mobile"];
        self.clubCard = [jsonMap objectForKey:@"clubCard"];
    }
    
    return self;
}

-(void)dealloc
{
    self.name = nil;
    self.gender = nil;
    self.nickName = nil;
    self.mobile = nil;
    self.clubCard = nil;
    
    [super dealloc];
}

@end
