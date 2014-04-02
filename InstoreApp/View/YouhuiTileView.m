//
//  YouhuiTileView.m
//  InstoreApp
//
//  Created by han chao on 14-3-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "YouhuiTileView.h"
#import "CouponDetailViewController.h"
#import "AppDelegate.h"

@implementation YouhuiTileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)awakeFromNib
{
    self.picView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.picView addGestureRecognizer:tap];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)tapAction:(UIGestureRecognizer *) gesture
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    CouponDetailViewController *cdvc = [[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil];
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    nav.visibleViewController.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:cdvc animated:YES];
}

@end
