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

@property (nonatomic, assign) NSInteger cid;            //itemId对象id
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *shortTitle;     //短标题
@property (nonatomic, assign) NSInteger promotionType;  //优惠类型 (1, '优惠活动'), (2, '优惠券'), (3, '团购')
@property (nonatomic, retain) NSString *hotTag;         //HOT标签
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain) NSString *descriptionStr; //详情描述
@property (nonatomic, retain) NSString *instruction;    //优惠券使用说明  (仅限堂食。。。)

@property (nonatomic, assign) NSInteger collectType;    //下载方式// 0: 免费下, 1: 分享后下载
@property (nonatomic, assign) NSInteger collectLimit;   //限量 0: 不限制; N: 限制下载N次,
@property (nonatomic, assign) NSInteger collectRole;    // 待定, 目前返回空,统一处理为每人限下载一次
@property (nonatomic, assign) NSInteger userCollectCount;//我的下载次数// 已下载返回1,未下载返回0.

@property (nonatomic, retain) NSString *oldPrice;       //原价
@property (nonatomic, retain) NSString *price;          //现价
@property (nonatomic, assign) NSInteger collectCount;   //下载数，团购时：参与人数，优惠券：下载数
@property (nonatomic, assign) NSInteger commentCount;   //评论数
@property (nonatomic, assign) NSInteger focusCount;     //收藏数
@property (nonatomic, retain) NSDate *startTime;
@property (nonatomic, retain) NSDate *endTime;
@property (nonatomic, assign) BOOL isFocus;             //是否已收藏，显示红心
@property (retain, nonatomic) NSString *link;           //外链地址
@property (retain, nonatomic) NSDate *date;             //服务器当前时间
@property (nonatomic, retain) StoreModel *store;
@property (retain, nonatomic) NSArray *banklist;        //专属银行列表
@property (retain, nonatomic) NSArray *recommend;       //推荐列表

//优惠详情不存在的
@property (nonatomic, assign) NSInteger itemType;       //对象类型 固定为1 代表优惠
@property (assign, nonatomic) NSInteger itemId;         //轮播图需要
@property (nonatomic, retain) NSString *summary;        //摘要，每日优惠、商场活动用到
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *source;         //团购来源

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
