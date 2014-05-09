//
//  UserInfoInterface.h
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@class UserInfoModel;
@protocol UserInfoInterfaceDelegate <NSObject>

-(void)getUserInfoDidFinished:(UserInfoModel *)userInfo;
-(void)getUserInfoDidFailed:(NSString *)errorMessage;

-(void)setUserInfoDidFinished;
-(void)setUserInfoDidFailed:(NSString *)errorMessage;

@end

@interface UserInfoInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<UserInfoInterfaceDelegate> delegate;

-(void)getUserInfo;

-(void)setUserInfo:(UserInfoModel *)userInfo;

@end
