//
//  DailyDealModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DailyDealModel.h"

@implementation DailyDealModel

-(id)initWithJsonMap:(NSDictionary*)jsonMap
{
    if (self = [super init]) {
        self.title = [jsonMap objectForKey:@"title"];
        self.shortTitle = [jsonMap objectForKey:@"shortTitle"];
        self.summary = [jsonMap objectForKey:@"summary"];
        self.image = [jsonMap objectForKey:@"image"];
        self.itemType = [[jsonMap objectForKey:@"itemType"] integerValue];
        self.itemId = [[jsonMap objectForKey:@"itemId"] integerValue];
        self.url = [jsonMap objectForKey:@"url"];
        self.promotionType = [[jsonMap objectForKey:@"promotionType"] integerValue];
        self.appCategory = [jsonMap objectForKey:@"appCategory"];
        self.fousCount = [[jsonMap objectForKey:@"fousCount"] integerValue];
    }
    return self;
}
-(void)dealloc{
    self.title = nil;
    self.shortTitle = nil;
    self.summary = nil;
    self.image = nil;
    self.url = nil;
    self.appCategory = nil;
    
    [super dealloc];
}

@end
