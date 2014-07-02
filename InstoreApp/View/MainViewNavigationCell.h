//
//  MainViewNavigationCell.h
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewNavigationCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIButton *mallActicityBtn; //商场活动
@property (nonatomic,strong) IBOutlet UIButton *couponBtn; //每日优惠
@property (nonatomic,strong) IBOutlet UIButton *foodBtn;  //找美食
@property (nonatomic,strong) IBOutlet UIButton *msgBtn;  //我的消息

@property (nonatomic,strong) IBOutlet UIButton *mapBtn;  //商场地图
@property (nonatomic,strong) IBOutlet UIButton *wifiBtn; //免费WIFI
@property (nonatomic,strong) IBOutlet UIButton *cardBtn; //银行卡恵
@property (nonatomic,strong) IBOutlet UIButton *myScoreBtn; //我的积分

- (IBAction)btnDailyDealAction:(UIButton *)sender;

- (IBAction)btnBackCardAction:(UIButton *)sender;

@property (strong, nonatomic) UINavigationController *nav;


@end
