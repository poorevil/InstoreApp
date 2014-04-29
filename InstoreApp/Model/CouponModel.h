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

@property (nonatomic,strong) NSDate *startTime;
@property (nonatomic,strong) NSDate *endTime;
@property (nonatomic,strong) NSString *cid;

@property (nonatomic,assign) NSInteger collectCount;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *tag;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,assign) NSInteger commentCount;
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) StoreModel *store;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
