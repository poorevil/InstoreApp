//
//  DailyDealInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol DailyDealInterfaceDelegate <NSObject>

-(void)getDailyDealDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;
-(void)getDailyDealDidFailed:(NSString *)errorMsg;

@end

@interface DailyDealInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<DailyDealInterfaceDelegate>delegate;

-(void)getDailyDealByPage:(NSInteger)page amount:(NSInteger)amount;

@end
