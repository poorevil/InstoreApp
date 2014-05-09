//
//  MyCouponsListInterface.h
//  InstoreApp
//  我关注的优惠接口
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol MyCouponsListInterfaceDelegate <NSObject>

-(void)getMyCouponsListDidFinished:(NSArray *)couponsArray totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
-(void)getMyCouponsListDidFailed:(NSString *)errorMessage;
@end

@interface MyCouponsListInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<MyCouponsListInterfaceDelegate> delegate;

-(void)getMyCouponsList;

@end
