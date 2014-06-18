//
//  FoodViewInterface.h
//  InstoreApp
//
//  Created by evil on 14-6-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol FoodViewInterfaceDelegate <NSObject>

-(void)getFoodListDidFinished:(NSArray *)resultList
                   totalCount:(NSInteger)totalCount
                  currentPage:(NSInteger)currentPage;

-(void)getFoodListDidFailed:(NSString *)errorMsg;

@end

@interface FoodViewInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic, assign) id<FoodViewInterfaceDelegate> delegate;

-(void)getFoodListByPage:(NSInteger)page amount:(NSInteger)amount;

@end
