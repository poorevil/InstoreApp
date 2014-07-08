//
//  CouponSearchOrderInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol CouponSearchOrderInterfaceDelegate <NSObject>

-(void)couponSearchOrderDidFinished:(NSArray *)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
-(void)couponSearchOrderDidFailed:(NSString*)errorMessage;

@end

@interface CouponSearchOrderInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<CouponSearchOrderInterfaceDelegate>delegate;

-(void)searchByAmount:(NSInteger)amount Page:(NSInteger)page Cid:(NSInteger)cid Type:(NSInteger)type Order:(NSString *)order;

@end
