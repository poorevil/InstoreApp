//
//  UserInfoInterface.m
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "UserInfoInterface.h"
#import "JSONKit.h"
#import "UserInfoModel.h"

@interface UserInfoInterface()

@property (nonatomic,assign) NSInteger requestType;

@end

@implementation UserInfoInterface

-(void)getUserInfo
{
    self.requestType = 0;
    
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.baseDelegate = self;
    [self connect];
}

-(void)setUserInfo:(UserInfoModel *)userInfo
{
    self.requestType = 1;
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"name":userInfo.name,
                  @"gender":userInfo.gender,
                  @"nickName":userInfo.nickName};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Info
-(void)parseResult:(ASIHTTPRequest *)request{
    if (self.requestType==1) {
        if ([self.delegate respondsToSelector:@selector(setUserInfoDidFinished)]) {
            [self.delegate setUserInfoDidFinished];
        }
    }else{
        NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
        id jsonObj = [jsonStr objectFromJSONString];
        
        if (jsonObj) {
            UserInfoModel *userInfo = nil;
            if (jsonObj) {
                userInfo = [[[UserInfoModel alloc] initWithJsonDict:jsonObj] autorelease];
            }
            
            if ([self.delegate respondsToSelector:@selector(getUserInfoDidFinished:)]) {
                [self.delegate getUserInfoDidFinished:userInfo];
            }
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (self.requestType==1) {
        if ([self.delegate respondsToSelector:@selector(setUserInfoDidFailed:)]) {
            [self.delegate setUserInfoDidFailed:[NSString stringWithFormat:@"修改失败！(%@)",error]];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(getUserInfoDidFailed:)]) {
            [self.delegate getUserInfoDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
        }
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}
@end
