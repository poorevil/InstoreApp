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
//见文档:https://github.com/joyx-inc/vmall#商户详细信息接口
-(id)initWithJsonMap:(NSDictionary*)jsonMap
{
    if (self = [super init]) {
        if (jsonMap && ![jsonMap isKindOfClass:[NSNull class]]) {
            self.sid = [[jsonMap objectForKey:@"id"] integerValue];
            self.title = [jsonMap objectForKey:@"title"];
            self.logoUrl = [jsonMap objectForKey:@"logo"];
            self.address = [jsonMap objectForKey:@"address"];
            self.tel = [jsonMap objectForKey:@"tel"];
            self.categoryModel = [[CategoryModel alloc] initWithJsonMap:[jsonMap objectForKey:@"category"]];
            self.position = [[PositionModel alloc ]initWithJsonMap:[jsonMap objectForKey:@"pos"]];
            self.descStr = [jsonMap objectForKey:@"description"];
            self.followerCount = [jsonMap objectForKey:@"followerCount"]==nil?0:[[jsonMap objectForKey:@"followerCount"] integerValue];
            self.isFocus = [[jsonMap objectForKey:@"isFocus"] boolValue];
            self.imageUrl = [jsonMap objectForKey:@"image"];
            self.coupons = [NSMutableArray array];
            NSArray *coupons = [jsonMap objectForKey:@"coupons"];
            for (NSDictionary *couponDict in coupons) {
                [self.coupons addObject:[[CouponModel alloc] initWithJsonMap:couponDict]];
            }
            self.comments = [NSMutableArray array];
            NSArray *comments = [jsonMap objectForKey:@"comments"];
            for (NSDictionary *commentDict in comments) {
                [self.comments addObject:[[CommentModel alloc] initWithJsonMap:commentDict]];
            }
        }
    }
    
    return self;
}

@end
