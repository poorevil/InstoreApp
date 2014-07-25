//
//  MessageModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MessageModel.h"
#import "NSDate+DynamicDateString.h"

@implementation MessageModel

-(id)initWithJsonMap:(NSDictionary*)jsonMap{
    if (self = [super init]) {
        if (jsonMap) {
            self.messageID = [[jsonMap objectForKey:@"id"] integerValue];
            self.category = [jsonMap objectForKey:@"category"];
            self.title = [jsonMap objectForKey:@"title"];
            self.summary = [jsonMap objectForKey: @"summary"];
            self.readStatus = [[jsonMap objectForKey:@"readStatus"] integerValue];
            self.createDate = [NSDate dateFromString:[jsonMap objectForKey:@"createDate"]];
        }
    }
    return self;
}

-(void)dealloc{
    self.category = nil;
    self.title = nil;
    self.summary = nil;
    self.createDate = nil;
    
    [super dealloc];
}

@end
