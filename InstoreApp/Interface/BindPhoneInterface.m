//
//  BindPhoneInterface.m
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BindPhoneInterface.h"

@interface BindPhoneInterface()
@property (nonatomic,assign) NSInteger requestType;
@end

@implementation BindPhoneInterface

-(void)bindPhone:(NSString *)phoneNum
{
    self.requestType = 0;
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/send_sms",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"phonenum":phoneNum};
    self.baseDelegate = self;
    [self connect];
}

-(void)savePhoneNumByPhoneNum:(NSString *)phoneNum code:(NSString *)code
{
    self.requestType = 1;
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/save_phonenum",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"phonenum":phoneNum,
                  @"code":code};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
-(void)parseResult:(ASIHTTPRequest *)request{
    if (self.requestType==1) {
        if ([self.delegate respondsToSelector:@selector(savePhoneNumDidFinished)]) {
            [self.delegate savePhoneNumDidFinished];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(bindPhoneDidFinished)]) {
            [self.delegate bindPhoneDidFinished];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (self.requestType==1) {
        if ([self.delegate respondsToSelector:@selector(savePhoneNumDidFailed:)]) {
            [self.delegate savePhoneNumDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(bindPhoneDidFailed:)]) {
            [self.delegate bindPhoneDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
        }
    }
}


@end
