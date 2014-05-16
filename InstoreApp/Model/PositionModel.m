//
//  PositionModel.m
//  InstoreApp
//
//  Created by hanchao on 14-5-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "PositionModel.h"
#import "FloorModel.h"
#import "BuildingModel.h"

@implementation PositionModel

//{
//    "mapCode": "地图编号",
//    "building": {
//        "id": 楼宇ID,        // **int**
//        "name": "楼宇名称"
//    },
//    "floor": {
//        "id": 楼层ID,        // **int**
//        "name": "楼层名称"
//    },
//    "roomNum": "房间号"
//}
-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        self.mapCode = [jsonMap objectForKey:@"mapCode"];
        self.roomNum = [jsonMap objectForKey:@"roomNum"];
        
        if ([jsonMap objectForKey:@"building"]) {
            self.building = [[BuildingModel alloc] initWithJsonMap:[jsonMap objectForKey:@"building"]];
        }
        
        if ([jsonMap objectForKey:@"floor"]) {
            self.floor = [[FloorModel alloc] initWithJsonMap:[jsonMap objectForKey:@"floor"]];
        }
        
    }
    
    return self;
}
@end
