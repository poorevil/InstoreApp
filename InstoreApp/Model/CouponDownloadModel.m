//
//  CouponDownloadModel.m
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDownloadModel.h"
#import "NSDate+DynamicDateString.h"

@implementation CouponDownloadModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.status = [[jsonMap objectForKey:@"status"] integerValue];
            self.msg = [jsonMap objectForKey:@"msg"];
            self.couponCode = [jsonMap objectForKey:@"couponCode"];
            self.startTime = [NSDate dateFromString:[jsonMap objectForKey:@"couponStartTime"]];
            self.endTime = [NSDate dateFromString:[jsonMap objectForKey:@"couponExpiredTime"]];
            self.date = [NSDate dateFromString:[jsonMap objectForKey:@"date"]];
        }
    }
    
    return self;
}

-(void)dealloc
{
    self.msg = nil;
    self.couponCode = nil;
    self.startTime = nil;
    self.endTime = nil;
    self.date = nil;
    
    [super dealloc];
}
@end
