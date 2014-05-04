//
//  CouponDetailInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@class CouponModel;

@protocol CouponDetailInterfaceDelegate <NSObject>

-(void)getCouponDetailDidFinished:(CouponModel *)couponModel;
-(void)getCouponDetailDidFailed:(NSString *)errorMessage;

@end

@interface CouponDetailInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<CouponDetailInterfaceDelegate> delegate;

-(void)getCouponDetailByCouponId:(NSInteger)cid;

@end
