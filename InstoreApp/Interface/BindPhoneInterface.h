//
//  BindPhoneInterface.h
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol BindPhoneInterfaceDelegate <NSObject>

-(void)bindPhoneDidFinished;
-(void)bindPhoneDidFailed:(NSString *)errorMessage;

-(void)savePhoneNumDidFinished;
-(void)savePhoneNumDidFailed:(NSString *)errorMessage;

@end

@interface BindPhoneInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<BindPhoneInterfaceDelegate> delegate;

//获取短信验证码
-(void)bindPhone:(NSString *)phoneNum;
//保存手机号码
-(void)savePhoneNumByPhoneNum:(NSString *)phoneNum code:(NSString *)code;
@end
