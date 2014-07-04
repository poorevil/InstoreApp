//
//  BankCardModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BankCardModel.h"

@implementation BankCardModel

-(id)initWithJsonMap:(NSDictionary*)jsonMap{
    if (self = [super init]) {
        self.bankId = [[jsonMap objectForKey:@"id"] integerValue];
        self.name = [jsonMap objectForKey:@"name"];
        self.logo = [jsonMap objectForKey:@"logo"];
        self.slogan = [jsonMap objectForKey:@"slogan"];
        self.promotionCount = [[jsonMap objectForKey:@"promotionCount"] integerValue];
    }
    return self;
}

-(void)dealloc{
    self.name = nil;
    self.logo = nil;
    self.slogan = nil;
    
    [super dealloc];
}
@end
