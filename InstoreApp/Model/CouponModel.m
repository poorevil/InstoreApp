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
#import "BankCardModel.h"

@implementation CouponModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.cid = [[jsonMap objectForKey:@"id"] integerValue];
            self.title = [jsonMap objectForKey:@"title"];
            self.shortTitle = [jsonMap objectForKey:@"shortTitle"];
            self.promotionType = [[jsonMap objectForKey:@"promotionType"] integerValue];
            self.hotTag = [jsonMap objectForKey:@"hotTag"];
            self.images = [jsonMap objectForKey:@"images"]==nil?[NSMutableArray array]:[NSMutableArray arrayWithArray:[jsonMap objectForKey:@"images"]];
            self.descriptionStr = [jsonMap objectForKey:@"description"];
            self.instruction = [jsonMap objectForKey:@"instruction"];
            
            self.collectType = [[jsonMap objectForKey:@"collectType"] integerValue];
            self.collectLimit = [[jsonMap objectForKey:@"collectLimit"] integerValue];
            self.collectRole = [[jsonMap objectForKey:@"collectRole"] integerValue];
            self.userCollectCount = [[jsonMap objectForKey:@"userCollectCount"] integerValue];
            
            self.oldPrice = [jsonMap objectForKey:@"oldPrice"];
            self.price = [jsonMap objectForKey:@"price"];
            self.collectCount = [[jsonMap objectForKey:@"collectCount"] integerValue];
            self.commentCount = [[jsonMap objectForKey:@"commentCount"] integerValue];
            self.focusCount = [[jsonMap objectForKey:@"focusCount"] integerValue];
            self.startTime = [NSDate dateFromString:[jsonMap objectForKey:@"startTime"]];
            self.endTime = [NSDate dateFromString:[jsonMap objectForKey:@"endTime"]];
            self.isFocus = [[jsonMap objectForKey:@"isFocus"] boolValue];
            self.link = [jsonMap objectForKey:@"link"];
            self.date = [NSDate dateFromString:[jsonMap objectForKey:@"date"]];
            self.store = [[[StoreModel alloc] initWithJsonMap:[jsonMap objectForKey:@"store"]] autorelease];
            NSArray *array = [jsonMap objectForKey:@"bank_list"];
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                BankCardModel *model = [[BankCardModel alloc]initWithJsonMap:dict];
                [resultArray addObject:model];
                [model release];
            }
            self.banklist = resultArray;
                        
            self.itemType = [[jsonMap objectForKey:@"itemType"] integerValue];
            self.itemId = [[jsonMap objectForKey:@"itemId"] integerValue];
            self.summary = [jsonMap objectForKey:@"summary"];
            self.imageUrl = [jsonMap objectForKey:@"image"];
            self.source = [jsonMap objectForKey:@"source"];
        }
    }
    
    return self;
}

-(void)dealloc
{
    self.title = nil;
    self.shortTitle = nil;
    self.hotTag = nil;
    self.images = nil;
    self.descriptionStr = nil;
    self.instruction = nil;
    
    self.oldPrice = nil;
    self.price = nil;
    
    self.startTime = nil;
    self.endTime = nil;

    self.link = nil;
    self.date = nil;
    self.store = nil;
    self.banklist = nil;
    self.recommend = nil;
    
    
    self.summary = nil;
    self.imageUrl = nil;
    self.source = nil;
    
    [super dealloc];
}

@end
