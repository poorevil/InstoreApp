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

#import "GroupBuyDetailViewController.h"
#import "CouponDetailViewController.h"
#import "MallNewsDetailViewController.h"

#import "AppDelegate.h"

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
        
        tile.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(tapAction:)] autorelease];
        tile.tag = 900+i;
        [tile addGestureRecognizer:tap];
    }
    
    self.couponsParentView.frame = CGRectMake(self.couponsParentView.frame.origin.x,
                                              self.couponsParentView.frame.origin.y,
                                              self.couponsParentView.frame.size.width,
                                              coupons.count*80);
    self.frame = CGRectMake(0, 0, self.frame.size.width, coupons.count*80+41);
}

-(void)tapAction:(UIGestureRecognizer *)gesture
{
    UIView *view = gesture.view;
    NSInteger idx = view.tag-900;
    CouponModel *cm = [self.coupons objectAtIndex:idx];
    
    UIViewController *vc = nil;
    switch (cm.promotionType ) {//优惠类型 (1, '优惠活动'), (2, '优惠券'), (3, '团购')
        case 3:
            vc = [[[GroupBuyDetailViewController alloc] initWithNibName:@"GroupBuyDetailViewController" bundle:nil] autorelease];
            break;
        case 2:
            vc = [[[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil] autorelease];
            break;
        case 1:
            vc = [[[MallNewsDetailViewController alloc]init]autorelease];
            break;
    }
    [vc setCouponModel:cm];
    vc.hidesBottomBarWhenPushed = YES;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    [nav pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}


-(void)dealloc
{
    self.coupons = nil;
    self.couponsParentView = nil;
    
    [super dealloc];
}
@end
