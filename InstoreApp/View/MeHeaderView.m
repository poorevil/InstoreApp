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

#import "UserInfoModel.h"
#import "EGOImageView.h"

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
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"me_headview_bg@2x" ofType:@"png"]]];    
    
    self.headIconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.headIconImageView addGestureRecognizer:tap];
    [tap release];
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
    BindPhoneViewController *bpvc = [[[BindPhoneViewController alloc] initWithNibName:@"BindPhoneViewController" bundle:nil] autorelease];
    bpvc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:bpvc animated:YES];
    bpvc.hidesBottomBarWhenPushed = NO;
}

-(void)setUserInfo:(UserInfoModel *)userInfo
{
    _userInfo = userInfo;
    
    self.headIconImageView.imageURL = [NSURL URLWithString:userInfo.headUrl];
    self.nickNameLabel.text = self.userInfo.name;
    self.cardNumLabel.text = self.userInfo.clubCard;
    self.pointLabel.text = [NSString stringWithFormat:@"%d",self.userInfo.points];
}

-(void)dealloc
{
    self.headIconImageView = nil;
    self.cardNumLabel = nil;
    self.nickNameLabel = nil;
    self.userInfo = nil;
    self.pointLabel = nil;
    
    [super dealloc];
}
@end
