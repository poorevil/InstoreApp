//
//  FocusedStoreListInterface.h
//  InstoreApp
//
//  Created by evil on 14-7-14.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol FocusedStoreListInterfaceDelegate <NSObject>

-(void)getFocusedStoreListDidFinished:(NSArray *)itemList
                           totalCount:(NSInteger)totalCount
                          currentPage:(NSInteger)currentPage
                           storeCount:(NSInteger)storeCount;

-(void)getFocusedStoreListDidFailed:(NSString *)errorMsg;

@end

@interface FocusedStoreListInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic, assign) id<FocusedStoreListInterfaceDelegate> delegate;

-(void)getFocusedStoreListByAmount:(NSInteger)amount page:(NSInteger)page
                             order:(NSString *)order category:(NSString *)category;

@end
