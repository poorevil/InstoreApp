//
//  CouponDownInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@class CouponDownloadModel;
@protocol CouponDownloadInterfaceDelegate <NSObject>

-(void)getCouponDownloadDidFinished:(CouponDownloadModel *)couponDownloadModel;
-(void)getCouponDownloadDidFailed:(NSString *)errorMessage;

@end

@interface CouponDownloadInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<CouponDownloadInterfaceDelegate> delegate;

-(void)getCouponDownloadByCouponId:(NSInteger)couponId;
@end
