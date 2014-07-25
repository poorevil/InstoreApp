//
//  ShopDetailItemListCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopDetailItemListCell.h"
#import "EGOImageView.h"
#import "StoreModel.h"
#import "CouponModel.h"
#import "CouponDetailViewController.h"
#import "AppDelegate.h"

@implementation ShopDetailItemListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib
{
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:248.0f/255.0f
                                                                     green:40.0f/255.0f
                                                                      blue:53.0f/255.0f
                                                                     alpha:1];
    
    [self refreshScrollView];
}


-(void)refreshScrollView
{
    if (self.storeModel.coupons.count>0) {
        self.pageControl.numberOfPages = ceil(self.storeModel.coupons.count/4.0f);
        self.pageControl.currentPage = 0;
        
        self.mscrollView.contentSize = CGSizeMake(self.bounds.size.width * self.pageControl.numberOfPages, 75);
        self.mscrollView.pagingEnabled = YES;
        
        for (int i = 0; i < self.storeModel.coupons.count; i++) {
            CouponModel *couponModel = [self.storeModel.coupons objectAtIndex:i];
            EGOImageView *imageview = [[[EGOImageView alloc] init] autorelease];
            imageview.userInteractionEnabled = YES;
            imageview.clipsToBounds = YES;
            imageview.tag = 900+i;
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.frame = CGRectMake(i*78+10 + (i/4*6),
                                         5, 70, 70);
            imageview.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/100*100.png",couponModel.imageUrl]];
            [self.mscrollView addSubview:imageview];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imageview addGestureRecognizer:tap];
        }
        
        
    }else{
        self.pageControl.numberOfPages = 0;
        self.pageControl.currentPage = 0;
        
        for (UIView *v in self.mscrollView.subviews) {
            if ([v isMemberOfClass:[EGOImageView class]]) {
                [v removeFromSuperview];
            }
        }
    }
}

-(void)setStoreModel:(StoreModel *)storeModel
{
    _storeModel = storeModel;
    
    [self refreshScrollView];
}

-(void)tapAction:(UIGestureRecognizer *)gesture
{
    if ([gesture.view isMemberOfClass:[EGOImageView class]]) {
        CouponModel *coupon = [self.storeModel.coupons objectAtIndex:gesture.view.tag-900];
        CouponDetailViewController *cdvc = [[[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil] autorelease];
        cdvc.couponModel = coupon;
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
        cdvc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:cdvc animated:YES];
        cdvc.hidesBottomBarWhenPushed = NO;
        
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.mscrollView.frame);
    NSUInteger page = floor((self.mscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

-(void)dealloc
{
    self.mscrollView = nil;
    self.pageControl = nil;
    self.storeModel = nil;
    
    [super dealloc];
}

@end
