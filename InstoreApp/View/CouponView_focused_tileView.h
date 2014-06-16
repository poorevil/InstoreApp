//
//  CouponView_focused_tileView.h
//  InstoreApp
//
//  Created by evil on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CouponModel;
@class EGOImageView;

@interface CouponView_focused_tileView : UIView

@property (nonatomic, retain) CouponModel *cm;

@property (nonatomic, retain) IBOutlet EGOImageView *logoImageView;
@property (nonatomic, retain) IBOutlet UILabel *logoNameLabel;//品牌名称
@property (nonatomic, retain) IBOutlet EGOImageView *couponImageView;
@property (nonatomic, retain) IBOutlet UILabel *tagLabel;//推荐标签
@property (nonatomic, retain) IBOutlet UILabel *promotionTypeLabel;//团、券、惠
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIImageView *watchImageView;
@property (nonatomic, retain) IBOutlet UILabel *endTimeLabel;
@property (nonatomic, retain) IBOutlet UIButton *favorBtn;
@property (nonatomic, retain) IBOutlet UIButton *shareBtn;

@property (nonatomic, retain) IBOutlet UIView *parentView;

@end
