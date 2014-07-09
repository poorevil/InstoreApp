//
//  CouponSectionTwoInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//


//优惠列表"可能感兴趣的优惠"接口

#import "BaseInterface.h"

@protocol CouponSectionTwoInterfaceDelegate <NSObject>

- (void)getCouponSectionTwoListDidFinished:(NSArray *)resultArray
                          focusCount:(NSInteger)focusCount
                          totalCount:(NSInteger)totalCount
                         currentPage:(NSInteger)currentPage;
- (void)getCouponSectionTwoListDidFailed:(NSString *)errorMsg;

@end

@interface CouponSectionTwoInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<CouponSectionTwoInterfaceDelegate>delegate;
- (void)getCouponSectionTwoListByPage:(NSInteger)page amount:(NSInteger)amount;

@end
