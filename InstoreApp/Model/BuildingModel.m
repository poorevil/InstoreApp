//
//  BuildingModel.m
//  InstoreApp
//
//  Created by hanchao on 14-5-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BuildingModel.h"

@implementation BuildingModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        self.bid = [[jsonMap objectForKey:@"id"] integerValue];
        self.name = [jsonMap objectForKey:@"name"];
    }
    
    return self;
}

@end
