//
//  MyDownloadCouponInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol MyDownloadCouponInterfaceDelegate <NSObject>

-(void)getMyDownloadCouponListDidFinished:(NSArray *)array;
-(void)getMyDownloadCouponListListDidFailed:(NSString *)errorMsg;

@end

@interface MyDownloadCouponInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<MyDownloadCouponInterfaceDelegate>delegate;
-(void)getMyDownloadCouponList;

@end


