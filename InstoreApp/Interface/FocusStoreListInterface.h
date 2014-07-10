//
//  FocusStoreListInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol FocusStoreListInterfaceDelegate <NSObject>

-(void)getFocusStoreListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage storeCount:(NSInteger)storeCount recommend:(BOOL)recommend;
-(void)getFocusStoreListDidFailed:(NSString *)errorMsg;

@end

@interface FocusStoreListInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<FocusStoreListInterfaceDelegate>delegate;
-(void)getFocusStoreListWithAmout:(NSInteger)amount Page:(NSInteger)page Caregory:(NSString *)category;

@end
