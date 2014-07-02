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

    [self.mallActicityBtn addTarget:self
                             action:@selector(mallActicityBtnAction:)
                   forControlEvents:UIControlEventTouchUpInside];
//    self.couponBtn addTarget:<#(id)#> action:<#(SEL)#> forControlEvents:<#(UIControlEvents)#>
//    [self.saleBtn addTarget:self action:@selector(saleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.cardBtn addTarget:self action:@selector(cardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)mallActicityBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    MallNewsViewController *mnVC = [[[MallNewsViewController alloc] initWithNibName:@"MallNewsViewController"
                                                                             bundle:nil] autorelease];
    mnVC.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:mnVC animated:YES];
    mnVC.hidesBottomBarWhenPushed = NO;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

-(void)mapBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    IndoorMapWithLeftPopBtnViewController *imvc = [[[IndoorMapWithLeftPopBtnViewController alloc] initWithFrame:nav.view.bounds] autorelease];
    imvc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:imvc animated:YES];
    imvc.hidesBottomBarWhenPushed = NO;
}

//-(void)saleBtnAction:(id)sender
//{
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    [appDelegate.tabBarController setSelectedIndex:1];
//}
//
//-(void)cardBtnAction:(id)sender
//{
//    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//    [appDelegate.tabBarController setSelectedIndex:4];
//}

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
- (IBAction)btnDailyDealAction:(UIButton *)sender {
    DailyDealViewController *ddVC = [[DailyDealViewController alloc]init];
    ddVC.hidesBottomBarWhenPushed = YES;
    [self.nav pushViewController:ddVC animated:YES];
}

- (IBAction)btnBackCardAction:(UIButton *)sender {
    BankCardViewController *bankCardVC = [[BankCardViewController alloc]init];
    bankCardVC.hidesBottomBarWhenPushed = YES;
    self.nav.title = @"我的卡恵";
    [self.nav pushViewController:bankCardVC animated:YES];
    self.nav.navigationItem.leftBarButtonItem.title = @"";
}
@end
