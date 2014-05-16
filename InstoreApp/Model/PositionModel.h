//
//  PositionModel.h
//  InstoreApp
//  位置
//  Created by hanchao on 14-5-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FloorModel;
@class BuildingModel;
@interface PositionModel : NSObject

@property (nonatomic,strong) BuildingModel *building;
@property (nonatomic,strong) FloorModel *floor;
@property (nonatomic,strong) NSString *mapCode;
@property (nonatomic,strong) NSString *roomNum;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;
@end
