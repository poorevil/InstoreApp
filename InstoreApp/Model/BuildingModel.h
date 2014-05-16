//
//  BuildingModel.h
//  InstoreApp
//  楼宇
//  Created by hanchao on 14-5-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingModel : NSObject

@property (nonatomic,assign) NSInteger bid;
@property (nonatomic,strong) NSString *name;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
