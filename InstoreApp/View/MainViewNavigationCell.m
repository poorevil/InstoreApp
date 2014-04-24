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
    [self setBtnStyle:self.foodBtn];
    [self setBtnStyle:self.cardBtn];
    [self setBtnStyle:self.orderBtn];
    [self setBtnStyle:self.saleBtn];

    [self setBtnStyle:self.mapBtn];
    [self setBtnStyle:self.wifiBtn];
    
    [self.mapBtn addTarget:self action:@selector(mapBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.saleBtn addTarget:self action:@selector(saleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cardBtn addTarget:self action:@selector(cardBtnAction:) forControlEvents:UIControlEventTouchUpInside];
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
                                          (btn.frame.size.width-btn.imageView.frame.size.width)/2-5,
                                          (btn.frame.size.height-btn.imageView.frame.size.height)/2 +5,
                                          0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height +5,
                                          -btn.imageView.frame.size.width,
                                          0, 0)];
    
//    btn.backgroundColor = [UIColor blackColor];
}

-(void)mapBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    IndoorMapWithLeftPopBtnViewController *imvc = [[IndoorMapWithLeftPopBtnViewController alloc] initWithFrame:nav.view.bounds];
    imvc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:imvc animated:YES];
    imvc.hidesBottomBarWhenPushed = NO;
}

-(void)saleBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.tabBarController setSelectedIndex:1];
}

-(void)cardBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.tabBarController setSelectedIndex:4];
}

@end
