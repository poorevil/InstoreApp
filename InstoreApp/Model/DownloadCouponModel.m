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
            self.description = [jsonMap objectForKey:@"description"];
            self.instruction = [jsonMap objectForKey:@"instruction"];
            self.couponCode = [jsonMap objectForKey:@"couponCode"];
            self.couponStatus = [[jsonMap objectForKey:@"couponStatus"] integerValue];
            self.barCodeUrl = [jsonMap objectForKey:@"barCodeUrl"];
            self.startTime = [NSDate dateFromString:[jsonMap objectForKey:@"startTime"]];
            self.endTime = [NSDate dateFromString:[jsonMap objectForKey:@"endTime"]];
            self.downloadTime = [NSDate dateFromString:[jsonMap objectForKey:@"downloadTime"]];
            self.imageURL = [jsonMap objectForKey:@"image"];
            self.storeModel = [[[StoreModel alloc]initWithJsonMap:[jsonMap objectForKey:@"store"]]autorelease];
        }
    }
    return self;
}

-(void)dealloc{
    self.title = nil;
    self.instruction = nil;
    self.couponCode = nil;
    self.barCodeUrl = nil;
    self.startTime = nil;
    self.endTime = nil;
    self.downloadTime = nil;
    self.storeModel = nil;
    
    [super dealloc];
}
@end
