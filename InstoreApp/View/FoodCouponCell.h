//
//  FoodCouponCell.h
//  InstoreApp
//
//  Created by evil on 14-6-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CouponModel;
@interface FoodCouponCell : UITableViewCell
@property (nonatomic, retain) CouponModel *cm1;
@property (nonatomic, retain) CouponModel *cm2;

@property (nonatomic, retain) UIView *leftView;
@property (nonatomic, retain) UIView *rightView;

@end
