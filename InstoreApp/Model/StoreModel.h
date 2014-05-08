//
//  StoreModel.h
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CategoryModel;
@class FloorModel;
@interface StoreModel : NSObject

@property (nonatomic,assign) NSInteger sid;
@property (nonatomic,strong) NSString *logoUrl;
@property (nonatomic,strong) CategoryModel *categoryModel;
@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *storeNo;
@property (nonatomic,strong) FloorModel *floor;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *mapid;
@property (nonatomic,strong) NSString *tel;

@property (nonatomic,assign) NSInteger followerCount;

@property (nonatomic,strong) NSMutableArray *coupons;
@property (nonatomic,strong) NSMutableArray *comments;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
