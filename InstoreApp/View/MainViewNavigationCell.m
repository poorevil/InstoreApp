//
//  MainViewNavigationCell.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewNavigationCell.h"
#import "AppDelegate.h"
#import "IndoorMapWithLeftPopBtnViewController.h"

#import "MallNewsViewController.h"
#import "DailyDealViewController.h"
#import "BankCardViewController.h"
#import "FoodViewController.h"

@implementation MainViewNavigationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [self setBtnStyle:self.mallActicityBtn];
    [self setBtnStyle:self.couponBtn];
    [self setBtnStyle:self.foodBtn];
    [self setBtnStyle:self.msgBtn];
    
    [self setBtnStyle:self.mapBtn];
    [self setBtnStyle:self.wifiBtn];
    [self setBtnStyle:self.cardBtn];
    [self setBtnStyle:self.myScoreBtn];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
//    [self.nav.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f green:40.0f/255.0f blue:53.0f/255.0f alpha:1]];
//    [self.nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    [self.mallActicityBtn addTarget:self
                             action:@selector(mallActicityBtnAction:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    [self.mapBtn addTarget:self action:@selector(mapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.foodBtn addTarget:self action:@selector(foodBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)dealloc
{
    self.mallActicityBtn = nil;
    self.couponBtn = nil;
    self.foodBtn = nil;
    self.msgBtn = nil;
    self.mapBtn = nil;
    self.wifiBtn = nil;
    self.cardBtn = nil;
    self.myScoreBtn = nil;
    
    self.nav = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)setBtnStyle:(UIButton *)btn
{
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                             (btn.frame.size.width-btn.imageView.frame.size.width)/2,
                                             (btn.frame.size.height-btn.imageView.frame.size.height)/2 +5,
                                             0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height +5,
                                             -btn.imageView.frame.size.width,
                                             0, 0)];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
}

#pragma mark - 主页上8个按钮事件
#pragma mark 商场活动
-(void)mallActicityBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    MallNewsViewController *mnVC = [[[MallNewsViewController alloc] initWithNibName:@"MallNewsViewController" bundle:nil] autorelease];
    mnVC.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:mnVC animated:YES];
    mnVC.hidesBottomBarWhenPushed = NO;
}

#pragma mark 商场地图
-(void)mapBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    IndoorMapWithLeftPopBtnViewController *imvc = [[[IndoorMapWithLeftPopBtnViewController alloc] initWithFrame:nav.view.bounds] autorelease];
    imvc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:imvc animated:YES];
    imvc.hidesBottomBarWhenPushed = NO;
}
#pragma mark 找美食
-(void)foodBtnAction:(id)sender{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.tabBarController setSelectedIndex:2];
}
//-(void)saleBtnAction:(id)sender
//{
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    [appDelegate.tabBarController setSelectedIndex:1];
//}

#pragma mark 每日优惠
- (IBAction)btnDailyDealAction:(UIButton *)sender {
    DailyDealViewController *ddVC = [[DailyDealViewController alloc]initWithNibName:@"DailyDealViewController" bundle:nil];
    ddVC.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:ddVC animated:YES];
    [ddVC release];
}
#pragma mark 我的卡恵
- (IBAction)btnBackCardAction:(UIButton *)sender {
    BankCardViewController *bankCardVC = [[BankCardViewController alloc]init];
    bankCardVC.hidesBottomBarWhenPushed = YES;
    self.nav.title = @"我的卡恵";
    [self.nav pushViewController:bankCardVC animated:YES];
    self.nav.navigationItem.leftBarButtonItem.title = @"";
    [bankCardVC release];
}
@end
