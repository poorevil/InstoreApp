//
//  FocusStoreModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusStoreModel.h"

@implementation FocusStoreModel

-(id)initWithJsonMap:(NSDictionary*)jsonMap{
    if (self = [super init]) {
        self.storeID = [[jsonMap objectForKey:@"id"] integerValue];
        self.title = [jsonMap objectForKey:@"title"];
        self.logo = [jsonMap objectForKey:@"logo"];
        self.followerCount = [[jsonMap objectForKey:@"followerCount"] integerValue];
        self.isFocus = [[jsonMap objectForKey:@"isFocus"] boolValue];
    }
    return self;
}

-(void)dealloc{
    self.title = nil;
    self.logo = nil;
    
    [super dealloc];
}

@end
