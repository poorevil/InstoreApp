//
//  BankCardDetailModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-4.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BankCardDetailModel.h"

@implementation BankCardDetailModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap{
    if (self = [super init]) {
//        self.bank = [[[BankCardModel alloc]initWithJsonMap:[js]]]
        self.youHuiId = [[jsonMap objectForKey:@"id"] integerValue];
        self.title = [jsonMap objectForKey:@"title"];
        self.promotionType = [jsonMap objectForKey:@"promotionType"];
        self.image = [jsonMap objectForKey:@"image"];
        self.startTime = [jsonMap objectForKey:@"startTime"];
        self.endTime = [jsonMap objectForKey:@"endTime"];
        self.store = [[[StoreModel alloc]initWithJsonMap:[jsonMap objectForKey:@"store"]]autorelease];
    }
    return self;
}

-(void)dealloc{
    self.bank = nil;
    self.title = nil;
    self.promotionType = nil;
    self.image = nil;
    self.startTime = nil;
    self.endTime = nil;
    self.store = nil;
    
    [super dealloc];
}
@end
