//
//  FoodViewPromotionInterface.h
//  InstoreApp
//
//  Created by evil on 14-6-19.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol FoodViewPromotionInterfaceDelegate <NSObject>

-(void)getFoodViewPromotionListDidFinished:(NSArray *)itemList
                                totalCount:(NSInteger)totalCount
                               currentPage:(NSInteger)currentPage;

-(void)getFoodViewPromotionListDidFailed:(NSString *)errorMsg;

@end


@interface FoodViewPromotionInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic, assign) id<FoodViewPromotionInterfaceDelegate> delegate;

-(void)getFoodViewPromotionListByPage:(NSInteger)page amount:(NSInteger)amount;

@end
