//
//  AddBankCardModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "AddBankCardModel.h"

@implementation AddBankCardModel

-(id)initWithJsonMap:(NSDictionary*)jsonMap{
    if (self = [super init]) {
        self.bankId = [[jsonMap objectForKey:@"id"] integerValue];
        self.name = [jsonMap objectForKey:@"name"];
        self.logo = [jsonMap objectForKey:@"logo"];
        self.choosed = [[jsonMap objectForKey:@"choosed"] boolValue];
    }
    return self;
}

-(void)dealloc{
    self.name = nil;
    self.logo = nil;
    
    [super dealloc];
}

@end
