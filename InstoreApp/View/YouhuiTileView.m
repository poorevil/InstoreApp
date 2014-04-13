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

    self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.7].CGColor;
    self.layer.borderWidth = 0.5f;
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
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    CouponDetailViewController *cdvc = [[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil];
    cdvc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:cdvc animated:YES];
    cdvc.hidesBottomBarWhenPushed = NO;
}

@end
