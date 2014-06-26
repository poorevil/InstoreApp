//
//  MallNewsModel.m
//  InstoreApp
//
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsModel.h"

#import "NSDate+DynamicDateString.h"

@implementation MallNewsModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        self.title = [jsonMap objectForKey:@"title"];
        self.mid = [[jsonMap objectForKey:@"id"] integerValue];
        self.summary = [jsonMap objectForKey:@"summary"];
        self.date = [jsonMap objectForKey:@"date"]?[NSDate dateFromString:[jsonMap objectForKey:@"date"]]:nil;
        self.url = [jsonMap objectForKey:@"url"];
        self.imageUrl = [jsonMap objectForKey:@"image"];
    }
    
    return self;
}

-(void)dealloc
{
    self.title = nil;
    self.summary = nil;
    self.date = nil;
    self.url = nil;
    self.imageUrl = nil;
    
    [super dealloc];
}



@end
