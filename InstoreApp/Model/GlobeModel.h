//
//  GlobeModel.h
//  InstoreApp
//
//  Created by evil on 14-4-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RuntimeModel;

@interface GlobeModel : NSObject

@property (nonatomic,strong) RuntimeModel *runtimeModel;
@property (nonatomic,strong) NSString *userId;

+ (GlobeModel *)sharedSingleton;

-(void)initUUIDIfNeeded;
@end
