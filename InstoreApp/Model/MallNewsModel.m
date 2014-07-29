//
//  MallNewsModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsModel.h"
#import "NSDate+DynamicDateString.h"

@implementation MallNewsModel

-(id)initWithJsonMap:(NSDictionary*)jsonMap{
    if (self = [super init]) {
        if (jsonMap) {
            self.title = [jsonMap objectForKey:@"title"];
            self.summary = [jsonMap objectForKey: @"summary"];
            self.cid = [[jsonMap objectForKey:@"id"] integerValue];
            self.image = [jsonMap objectForKey:@"image"];
            self.date = [NSDate dateFromString:[jsonMap objectForKey:@"date"]];
            self.url = [jsonMap objectForKey:@"url"];
        }
    }
    return self;
}

-(void)dealloc{
    self.title = nil;
    self.summary = nil;
    self.image = nil;
    self.date = nil;
    self.url = nil;
    
    [super dealloc];
}

@end
