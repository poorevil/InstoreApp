//
//  CouponModel.h
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoreModel;
@interface CouponModel : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, assign) NSInteger itemType;//对象类型 固定为1 代表优惠
@property (nonatomic, assign) NSInteger cid;//itemId对象id
@property (nonatomic, assign) NSInteger promotionType;//优惠类型 (1, '优惠活动'), (2, '优惠券'), (3, '团购')
@property (nonatomic, retain) NSString *oldPrice;//原价
@property (nonatomic, retain) NSString *price;//现价

@property (nonatomic, assign) NSInteger collectCount;//参与人数

@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSDate *endTime;
@property (nonatomic, retain) NSString *descriptionStr;
@property (nonatomic, retain) NSMutableArray *images;

//----
@property (nonatomic, retain) NSString *hotTag;
@property (nonatomic, retain) NSString *shortTitle;//短标题
@property (nonatomic, assign) NSInteger focusCount;//收藏数
//@property (nonatomic, assign) NSInteger collectCount;//TODO:下载数
@property (nonatomic, assign) BOOL isFocus;//是否已收藏，显示红心

@property (retain, nonatomic) NSString *link;  //外链地址
//团购
@property (nonatomic, retain) NSString *source;//团购来源



////@property (nonatomic,assign) NSInteger cid;
//

////@property (nonatomic,strong) NSString *title;
////@property (nonatomic,strong) NSString *imageUrl;
//@property (nonatomic,assign) CGFloat imageWidth;
//@property (nonatomic,assign) CGFloat imageHeight;
@property (nonatomic,assign) NSInteger commentCount;//评论数
//@property (nonatomic,assign) NSInteger type;
//
//@property (nonatomic,retain) NSDate *date;

//
@property (nonatomic,assign) NSInteger collectType;//下载方式// 0: 免费下, 1: 分享后下载
@property (nonatomic,assign) NSInteger collectLimit;//限量 0: 不限制; N: 限制下载N次,
@property (nonatomic,assign) NSInteger collectRole;// 待定, 目前返回空,统一处理为每人限下载一次
@property (nonatomic,assign) NSInteger userCollectCount;//我的下载次数// 已下载返回1,未下载返回0.
//

@property (nonatomic,strong) NSString *instruction;//优惠券使用说明
////@property (nonatomic,assign) NSInteger collectRole;//下载规则

//
//@property (nonatomic,strong) NSString *couponCode;//优惠券代码   // ('-1', '未知'),('0', '未消费'), ('1', '已消费')
//@property (nonatomic,assign) NSInteger couponStatus;//优惠券状态
//
@property (nonatomic,strong) StoreModel *store;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
