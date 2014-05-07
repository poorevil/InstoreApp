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
@property (nonatomic,assign) NSInteger cid;

@property (nonatomic,assign) NSInteger collectCount;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *tag;
@property (nonatomic,strong) NSString *imageUrl;
@property (nonatomic,assign) CGFloat imageWidth;
@property (nonatomic,assign) CGFloat imageHeight;
@property (nonatomic,assign) NSInteger commentCount;
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,assign) NSInteger downloadCount;
@property (nonatomic,retain) NSDate *date;
@property (nonatomic,retain) NSString *descriptionStr;
@property (nonatomic,retain) NSMutableArray *images;
@property (nonatomic,assign) NSInteger downloadLimit;

@property (nonatomic,assign) NSInteger collectType;
@property (nonatomic,assign) NSInteger collectLimit;
@property (nonatomic,assign) NSInteger collectRole;
@property (nonatomic,assign) NSInteger userCollectCount;

@property (nonatomic,strong) StoreModel *store;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
