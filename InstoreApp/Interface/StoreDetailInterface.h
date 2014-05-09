//
//  StoreDetailInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@class StoreModel;
@protocol StoreDetailInterfaceDelegate <NSObject>

-(void)getStoreDetailDidFinished:(StoreModel*)storeModel;
-(void)getStoreDetailDidFailed:(NSString *)errorMessage;

@end

@interface StoreDetailInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<StoreDetailInterfaceDelegate> delegate;

-(void)getStoreDetailByShopId:(NSInteger)shopId commentSize:(NSInteger)commentSize couponSize:(NSInteger)couponSize;

@end
