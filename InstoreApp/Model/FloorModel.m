//
//  FloorModel.m
//  InstoreApp
//
//  Created by evil on 14-4-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FloorModel.h"

@implementation FloorModel
//{
//  id: 'ID',
//name: '名称'
//}
-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if(self = [super init]){
        self.fid = [[jsonMap objectForKey:@"id"] integerValue];
        self.fName = [jsonMap objectForKey:@"name"];
        self.mapCode = [jsonMap objectForKey:@"mapCode"];
    }
    return self;
}

-(id)initWithJsonMap:(NSDictionary *)jsonMap buildingId:(NSInteger)buildingId
{
    if (self = [super init]) {
        self.fid = [[jsonMap objectForKey:@"id"] integerValue];
        self.fName = [jsonMap objectForKey:@"name"];
        self.mapCode = [jsonMap objectForKey:@"mapCode"];
        self.buildingId = buildingId;
    }
    return self;
}

-(void)dealloc
{
    self.fName = nil;
    self.mapCode = nil;
    [super dealloc];
}
@end
