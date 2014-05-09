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
@property (nonatomic,strong) IBOutlet UILabel *cardNumLabel;
@property (nonatomic,strong) IBOutlet UILabel *nickNameLabel;


@property (nonatomic,strong) UserInfoModel *userInfo;


@end
