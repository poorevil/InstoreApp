//
//  UserInfoModel.h
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic,strong) NSString *name;   //姓名
@property (nonatomic,assign) NSInteger gender; //性别
@property (nonatomic,strong) NSString *nickName;//昵称
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *clubCard;    //会员卡号
@property (retain, nonatomic) NSString *barCodeUrl; //条码图片地址
@property (nonatomic,strong) NSString *headUrl;//头像
@property (nonatomic,assign) NSInteger points;//积分
@property (retain, nonatomic) NSDate *birthday;
@property (nonatomic,assign) NSInteger promotionCount;//下载的优惠券数量
@property (retain, nonatomic) NSString *memberGuideUrl; //会员指南

@property (nonatomic,assign) BOOL isStoreFocusRecommend; // 接收已关注商家的优惠,  on: 启用; off: 关闭
@property (nonatomic,assign) BOOL isAutoConnectWifi;// 自动连接WIFI,            on: 启用; off: 关闭


-(id)initWithJsonDict:(NSDictionary *)jsonMap;

@end
