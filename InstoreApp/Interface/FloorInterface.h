//
//  FloorInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol FloorInterfaceDelegate <NSObject>

-(void)getFloorListDidFinished:(NSArray *)floorList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;
-(void)getFloorListDidFailed:(NSString *)errorMessage;

@end
@interface FloorInterface : BaseInterface <BaseInterfaceDelegate>
@property (nonatomic,assign) id<FloorInterfaceDelegate> delegate;

-(void)getFloorListByPage:(NSInteger)page amount:(NSInteger)amount;
@end
