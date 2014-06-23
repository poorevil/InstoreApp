//
//  StoreDetail_otherCouponTileView.h
//  InstoreApp
//
//  Created by evil on 14-6-24.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;
@class CouponModel;
@interface StoreDetail_otherCouponTileView : UIView

@property (nonatomic, retain) IBOutlet EGOImageView *logoImageVew;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *otherlabel;

@property (nonatomic, retain) CouponModel *couponModel;

@end
