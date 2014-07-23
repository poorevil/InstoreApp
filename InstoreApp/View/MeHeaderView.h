//
//  MeHeaderView.h
//  InstoreApp
//
//  Created by han chao on 14-3-30.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoModel;
@class EGOImageView;
@interface MeHeaderView : UIView

@property (nonatomic,strong) IBOutlet EGOImageView *headIconImageView;
@property (nonatomic,strong) IBOutlet UILabel *cardNumLabel;    //会员卡号
@property (nonatomic,strong) IBOutlet UILabel *nickNameLabel;  //昵称
@property (nonatomic,strong) IBOutlet UILabel *pointLabel;      //积分

- (IBAction)btnUpdataUserInfoAction:(UIButton *)sender;

@property (nonatomic,strong) UserInfoModel *userInfo;


@end
