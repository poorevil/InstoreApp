//
//  FloorInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol FloorInterfaceDelegate <NSObject>

-(void)getFloorListDidFinished:(NSArray *)floorList;
-(void)getFloorListDidFailed:(NSString *)errorMessage;

@end

@interface FloorInterface : BaseInterface <BaseInterfaceDelegate>
@property (nonatomic,assign) id<FloorInterfaceDelegate> delegate;

-(void)getFloorListByAreaId:(NSInteger)areaId;
@end
