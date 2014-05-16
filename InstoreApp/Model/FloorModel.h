//
//  FloorModel.h
//  InstoreApp
//  楼层Model
//  Created by evil on 14-4-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FloorModel : NSObject

@property (nonatomic,assign) NSInteger fid;
@property (nonatomic,strong) NSString *fName;
@property (nonatomic,strong) NSString *mapCode;
@property (nonatomic,assign) NSInteger buildingId;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;
-(id)initWithJsonMap:(NSDictionary *)jsonMap buildingId:(NSInteger)buildingId;
@end
