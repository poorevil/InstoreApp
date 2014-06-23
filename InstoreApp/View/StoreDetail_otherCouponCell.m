//
//  StoreDetail_otherCouponCell.m
//  InstoreApp
//
//  Created by evil on 14-6-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreDetail_otherCouponCell.h"

#import "CouponModel.h"
#import "StoreDetail_otherCouponTileView.h"

@implementation StoreDetail_otherCouponCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCoupons:(NSArray *)coupons
{
    [_coupons release];
    _coupons = [coupons retain];
    
    for (NSInteger i = 0;i < self.coupons.count;i++) {
        CouponModel *cm = [self.coupons objectAtIndex:i];
        StoreDetail_otherCouponTileView *tile = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetail_otherCouponTileView" owner:self options:nil] objectAtIndex:0];
        tile.couponModel = cm;
        tile.frame = CGRectMake(0, i*tile.frame.size.height,
                                tile.frame.size.width, tile.frame.size.height);
        [self.couponsParentView addSubview:tile];
    }
    
    self.couponsParentView.frame = CGRectMake(self.couponsParentView.frame.origin.x,
                                              self.couponsParentView.frame.origin.y,
                                              self.couponsParentView.frame.size.width,
                                              coupons.count*80);
    self.frame = CGRectMake(0, 0, self.frame.size.width, coupons.count*80+41);
}

-(void)dealloc
{
    self.coupons = nil;
    self.couponsParentView = nil;
    
    [super dealloc];
}
@end
