//
//  CouponView_empty_tileView.m
//  InstoreApp
//
//  Created by evil on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponView_empty_tileView.h"
#import "FocusStoreViewController.h"
#import "AppDelegate.h"

@implementation CouponView_empty_tileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)goNextVCAction:(UIButton *)sender {
    FocusStoreViewController *vc = [[FocusStoreViewController alloc]initWithNibName:@"FocusStoreViewController" bundle:nil];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
    [vc release];
}
@end
