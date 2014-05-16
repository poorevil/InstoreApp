//
//  CouponModel.m
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponModel.h"
#import "StoreModel.h"
#import "NSDate+DynamicDateString.h"

@implementation CouponModel


-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.cid = [[jsonMap objectForKey:@"id"] integerValue];
            self.title = [jsonMap objectForKey:@"title"];
            self.type = [[jsonMap objectForKey:@"type"] integerValue];
            self.hotTag = [jsonMap objectForKey:@"hotTag"];
            self.images = [jsonMap objectForKey:@"images"]==nil?[NSMutableArray array]:
                                            [NSMutableArray arrayWithArray:[jsonMap objectForKey:@"images"]];
            self.descriptionStr = [jsonMap objectForKey:@"description"];
            self.instruction = [jsonMap objectForKey:@"instruction"];
            self.collectType = [jsonMap objectForKey:@"collectType"]==nil?0:[[jsonMap objectForKey:@"collectType"] integerValue];
            self.collectLimit = [jsonMap objectForKey:@"collectLimit"]==nil?0:[[jsonMap objectForKey:@"collectLimit"] integerValue];
            self.collectRole = [jsonMap objectForKey:@"collectRole"]==[NSNull null]?0:[[jsonMap objectForKey:@"collectRole"] integerValue];
            self.userCollectCount = [jsonMap objectForKey:@"userCollectCount"]==nil?0:[[jsonMap objectForKey:@"userCollectCount"] integerValue];
            self.collectCount = [jsonMap objectForKey:@"collectCount"]?[[jsonMap objectForKey:@"collectCount"] integerValue]:0;
            self.commentCount = [jsonMap objectForKey:@"commentCount"]?[[jsonMap objectForKey:@"commentCount"] integerValue]:0;
            self.focusCount = [jsonMap objectForKey:@"focusCount"]==nil?0:[[jsonMap objectForKey:@"focusCount"] integerValue];
            self.startTime = [NSDate dateFromString:[jsonMap objectForKey:@"startTime"]];
            self.endTime = [NSDate dateFromString:[jsonMap objectForKey:@"endTime"]];

            self.imageUrl = [jsonMap objectForKey:@"image"];
            self.imageWidth = [jsonMap objectForKey:@"pixelWith"]?[[jsonMap objectForKey:@"pixelWith"] integerValue]:0;
            self.imageHeight = [jsonMap objectForKey:@"pixelHeight"]?[[jsonMap objectForKey:@"pixelHeight"] integerValue]:0;
            
            self.date = [jsonMap objectForKey:@"date"]==nil?nil:[NSDate dateFromString:[jsonMap objectForKey:@"date"]];
            
            self.store = [[StoreModel alloc] initWithJsonMap:[jsonMap objectForKey:@"store"]];
            
            self.couponStatus = [jsonMap objectForKey:@"coupon_status"]==nil?-1:[[jsonMap objectForKey:@"coupon_status"] integerValue];
            self.couponCode = [jsonMap objectForKey:@"couponCode"];
        }
    }
    
    return self;
}

@end
