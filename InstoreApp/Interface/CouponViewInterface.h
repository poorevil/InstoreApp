//
//  CouponViewInterface.h
//  InstoreApp
//  优惠列表"我收藏的商户优惠"接口
//  Created by hanchao on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

//优惠列表"我收藏的商户优惠"接口

#import "BaseInterface.h"

@protocol CouponViewInterfaceDelegate <NSObject>

- (void)getCouponViewListDidFinished:(NSArray *)resultArray
                          focusCount:(NSInteger)focusCount
                          totalCount:(NSInteger)totalCount
                         currentPage:(NSInteger)currentPage;
- (void)getCouponViewListDidFailed:(NSString *)errorMsg;

@end

@interface CouponViewInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic, assign) id<CouponViewInterfaceDelegate> delegate;

- (void)getCouponViewListByPage:(NSInteger)page amount:(NSInteger)amount;

@end
