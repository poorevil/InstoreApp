//
//  DailyDealModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyDealModel : NSObject

@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *shortTitle;
@property (retain, nonatomic) NSString *summary;
@property (retain, nonatomic) NSString *image;
@property (assign, nonatomic) NSInteger itemType;
@property (assign, nonatomic) NSInteger itemId;
@property (retain, nonatomic) NSString *url;
@property (assign, nonatomic) NSInteger promotionType;
@property (retain, nonatomic) NSString *appCategory;
@property (assign, nonatomic) NSInteger fousCount;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
