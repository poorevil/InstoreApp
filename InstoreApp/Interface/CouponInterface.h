//
//  CouponInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-4.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol CouponInterfaceDelegate <NSObject>

-(void)getCouponListDidFinished:(NSArray *)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
-(void)getCouponListDidFailed:(NSString *)errorMessage;

@end

@interface CouponInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<CouponInterfaceDelegate> delegate;

-(void)getCouponListByCid:(NSString *)cid
                   isLike:(NSInteger)isLike
                    order:(NSString *)order
                   amount:(NSInteger)amount
                     page:(NSInteger)pageNum;
@end
