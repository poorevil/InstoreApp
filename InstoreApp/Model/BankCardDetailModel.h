//
//  BankCardDetailModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-4.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreModel.h"
#import "BankCardModel.h"

@interface BankCardDetailModel : NSObject

@property (retain, nonatomic) BankCardModel *bank;
@property (assign, nonatomic) NSInteger youHuiId;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *promotionType;
@property (retain, nonatomic) NSString *image;
@property (retain, nonatomic) NSString *startTime;
@property (retain, nonatomic) NSString *endTime;
@property (retain, nonatomic) StoreModel *store;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
