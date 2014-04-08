//
//  MeHeaderView.m
//  InstoreApp
//  我的-账户view
//  Created by han chao on 14-3-30.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MeHeaderView.h"
#import "AppDelegate.h"
#import "BindPhoneViewController.h"

@implementation MeHeaderView

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
    self.headIconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.headIconImageView addGestureRecognizer:tap];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)tapAction:(UIGestureRecognizer *)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    BindPhoneViewController *bpvc = [[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil];
    bpvc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:bpvc animated:YES];
    bpvc.hidesBottomBarWhenPushed = NO;
}

@end
