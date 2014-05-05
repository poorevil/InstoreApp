//
//  StoreInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol StoreInterfaceDelegate <NSObject>

-(void)getStoreListDidFinished:(NSArray *)resultList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;
-(void)getStoreListDidFailed:(NSString *)errorMessage;

@end

@interface StoreInterface : BaseInterface <BaseInterfaceDelegate>
@property (nonatomic,assign) id<StoreInterfaceDelegate> delegate;

-(void)getStoreListByFloor:(NSString *)floor
                       cid:(NSInteger)cid
                     order:(NSString *)order
                    isLike:(NSInteger)isLike
                    amount:(NSInteger)amount
                      page:(NSInteger)page;

@end
