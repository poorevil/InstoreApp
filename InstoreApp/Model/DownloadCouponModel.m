//
//  DownloadCouponModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DownloadCouponModel.h"
#import "NSDate+DynamicDateString.h"

@implementation DownloadCouponModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap{
    if (self = [super init]) {
        if (jsonMap) {
            self.cid = [[jsonMap objectForKey:@"id"] integerValue];
            self.title = [jsonMap objectForKey:@"title"];
            self.instruction = [jsonMap objectForKey:@"instruction"];
            self.couponCode = [jsonMap objectForKey:@"couponCode"];
            self.couponStatus = [[jsonMap objectForKey:@"couponStatus"] integerValue];
            self.startTime = [NSDate dateFromString:[jsonMap objectForKey:@"startTime"]];
            self.endTime = [NSDate dateFromString:[jsonMap objectForKey:@"endTime"]];
            self.imageURL = [jsonMap objectForKey:@"image"];
            self.storeModel = [[StoreModel alloc]initWithJsonMap:[jsonMap objectForKey:@"store"]];
        }
    }
    return self;
}

-(void)dealloc{
    self.title = nil;
    self.instruction = nil;
    self.couponCode = nil;
    self.startTime = nil;
    self.endTime = nil;
    self.storeModel = nil;
    
    [super dealloc];
}
@end
