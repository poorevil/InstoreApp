//
//  CategoryModel.m
//  InstoreApp
//
//  Created by evil on 14-4-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

//{
//   "id": 2,
//   "name": "分类2"
//},
-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.cid = [[jsonMap objectForKey:@"id"] integerValue];
            self.cName = [jsonMap objectForKey:@"name"];
        }
    }
    
    return self;
}

-(void)dealloc
{
    self.cName = nil;
    [super dealloc];
}
@end
