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

@property (nonatomic,assign) NSInteger sid;
@property (nonatomic,strong) NSString *logoUrl;
@property (nonatomic,strong) CategoryModel *categoryModel;
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *roomNum;//商户房间号
@property (nonatomic,strong) PositionModel *position;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *descStr;
@property (nonatomic,assign) BOOL isFocus;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,assign) NSInteger followerCount;//关注人数

@property (nonatomic,strong) NSMutableArray *coupons;
@property (nonatomic,strong) NSMutableArray *comments;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
