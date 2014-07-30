//
//  DownloadCouponDetailInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-30.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"
#import "DownloadCouponModel.h"

@protocol DownloadCouponDetailInterfaceDelegate <NSObject>

-(void)getMyDownloadCouponDetailDidFinished:(DownloadCouponModel *)model;
-(void)getMyDownloadCouponDetailDidFailed:(NSString *)errorMsg;

@end

@interface DownloadCouponDetailInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<DownloadCouponDetailInterfaceDelegate>delegate;

-(void)getMyDownloadCouponDetailWithID:(NSInteger)cid;

@end
