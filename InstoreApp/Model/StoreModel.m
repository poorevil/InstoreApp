//
//  StoreModel.m
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreModel.h"
#import "PositionModel.h"
#import "CategoryModel.h"
#import "CouponModel.h"
#import "CommentModel.h"

@implementation StoreModel

-(id)initWithJsonMap:(NSDictionary*)jsonMap
{
    if (self = [super init]) {
        if (jsonMap && ![jsonMap isKindOfClass:[NSNull class]]) {
            self.sid = [[jsonMap objectForKey:@"id"] integerValue];
            self.title = [jsonMap objectForKey:@"title"];
            self.imageUrl = [jsonMap objectForKey:@"image"];
            self.itemType = [[jsonMap objectForKey:@"itemType"] integerValue];
            self.appCategory = [jsonMap objectForKey:@"appCategory"];
            
            self.avgPrice = [jsonMap objectForKey:@"avgprice"]==nil?0:[[jsonMap objectForKey:@"avgprice"] integerValue];
            self.slogan = [jsonMap objectForKey:@"slogan"];
            
            self.logoUrl = [jsonMap objectForKey:@"logo"];
            self.address = [jsonMap objectForKey:@"address"];
            self.tel = [jsonMap objectForKey:@"tel"];
            self.categoryModel = [[[CategoryModel alloc] initWithJsonMap:[jsonMap objectForKey:@"category"]] autorelease];
            self.position = [[[PositionModel alloc ]initWithJsonMap:[jsonMap objectForKey:@"pos"]] autorelease];
            
            self.promotionTypes = [jsonMap objectForKey:@"promotionTypes"];
            
            self.descStr = [jsonMap objectForKey:@"description"];
            self.followerCount = [jsonMap objectForKey:@"followerCount"]==nil?0:[[jsonMap objectForKey:@"followerCount"] integerValue];
            self.isFocus = [jsonMap objectForKey:@"isFocus"]?[[jsonMap objectForKey:@"isFocus"] boolValue]:NO;

            self.coupons = [NSMutableArray array];
            NSArray *coupons = [jsonMap objectForKey:@"coupons"];//coupons
            for (NSDictionary *couponDict in coupons) {
                [self.coupons addObject:[[[CouponModel alloc] initWithJsonMap:couponDict] autorelease]];
            }
            self.comments = [NSMutableArray array];
            NSArray *comments = [jsonMap objectForKey:@"comments"];
            for (NSDictionary *commentDict in comments) {
                [self.comments addObject:[[[CommentModel alloc] initWithJsonMap:commentDict] autorelease]];
            }
        }
    }
    
    return self;
}

-(void)dealloc
{
    self.logoUrl = nil;
    self.categoryModel = nil;
    self.title = nil;
    self.roomNum = nil;
    self.position = nil;
    self.address = nil;
    self.tel = nil;
    self.descStr = nil;
    self.imageUrl = nil;
    self.coupons = nil;
    self.comments = nil;
    self.slogan = nil;
    self.promotionTypes = nil;
    
    [super dealloc];
}
@end
