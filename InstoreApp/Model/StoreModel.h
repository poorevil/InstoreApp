//
//  StoreModel.h
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryModel;
@class PositionModel;
@interface StoreModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic, assign) NSInteger itemType;//对象类型 (2, '商户')
@property (nonatomic, assign) NSInteger sid;
@property (nonatomic, retain) NSString *appCategory;//商户类型时有效,商户对应的APP模板：Department("百货"),Restaurant("餐饮"),Entertainment("娱乐");




@property (nonatomic,strong) NSString *logoUrl;//logo图片地址
@property (nonatomic,strong) CategoryModel *categoryModel;


@property (nonatomic,strong) NSString *roomNum;//商户房间号
@property (nonatomic,strong) PositionModel *position;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *descStr;
@property (nonatomic,assign) BOOL isFocus;

@property (nonatomic,assign) NSInteger followerCount;//关注人数

@property (nonatomic,strong) NSMutableArray *coupons;
@property (nonatomic,strong) NSMutableArray *comments;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
