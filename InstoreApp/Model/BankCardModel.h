//
//  BankCardModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject

@property (assign, nonatomic) NSInteger bankId;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *logo;
@property (retain, nonatomic) NSString *slogan;
@property (assign, nonatomic) NSInteger promotionCount;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
