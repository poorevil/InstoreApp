//
//  MainView_ GroupBuyingCell.m
//  InstoreApp
//
//  Created by evil on 14-6-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_GroupBuyingCell.h"
#import "CouponModel.h"

#import "AppDelegate.h"
#import "GroupBuyDetailViewController.h"
#import "CouponDetailViewController.h"
#import "MallNewsDetailViewController.h"

#import "CustomNavigationController.h"
#import "CouponViewController.h"

@implementation MainView_GroupBuyingCell

- (void)awakeFromNib
{
    // Initialization code
    [self setBorder:self.imageView_1];
    [self setBorder:self.imageView_2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)moreBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.tabBarController.selectedIndex = 1;
    
    CustomNavigationController *nav = (CustomNavigationController *)appDelegate.tabBarController.selectedViewController;
    CouponViewController *vc = [nav.viewControllers objectAtIndex:0];
    
    [vc loadTypeData:3];
    vc.isOrder1 = YES;
    vc.isOrder = YES;
}

-(void)setDataList:(NSArray *)dataList
{
    [_dataList release];
    _dataList = [dataList retain];
    
    if (self.dataList.count == 2) {
        CouponModel *cm = [self.dataList objectAtIndex:0];
        self.titleLabel_1.text = cm.title;
        self.imageView_1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/300*300.png",cm.imageUrl]];
        self.imageView_1.tag = 0;
        self.imageView_1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(tapAction:)] autorelease];
        [self.imageView_1 addGestureRecognizer:tap];
        self.sourceLabel_1.text = cm.source;
        self.priceLabel_1.text = [NSString stringWithFormat:@"￥%@",cm.price];
        CGSize labelFontSize = [self.priceLabel_1.text sizeWithFont:self.priceLabel_1.font
                                              constrainedToSize:CGSizeMake(99999, self.priceLabel_1.frame.size.height)
                                                  lineBreakMode:self.priceLabel_1.lineBreakMode];
        self.priceLabel_1.frame = CGRectMake(self.priceLabel_1.frame.origin.x,
                                                self.priceLabel_1.frame.origin.y,
                                                labelFontSize.width,
                                                self.priceLabel_1.frame.size.height);
        
        self.oldPriceLabel_1.text = cm.oldPrice;
        labelFontSize = [self.oldPriceLabel_1.text sizeWithFont:self.oldPriceLabel_1.font
                                                     constrainedToSize:CGSizeMake(99999, self.oldPriceLabel_1.frame.size.height)
                                                         lineBreakMode:self.oldPriceLabel_1.lineBreakMode];
        self.oldPriceLabel_1.frame = CGRectMake(self.priceLabel_1.frame.origin.x+self.priceLabel_1.frame.size.width+2,
                                                self.oldPriceLabel_1.frame.origin.y,
                                                labelFontSize.width,
                                                self.oldPriceLabel_1.frame.size.height);
        self.oldPriceLabel_1.isWithStrikeThrough = YES;
        self.collectLabel_1.text = [NSString stringWithFormat:@"%d人参加",cm.collectCount];
        
        cm = [self.dataList objectAtIndex:1];
        self.titleLabel_2.text = cm.title;
        self.imageView_2.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/300*300.png",cm.imageUrl]];
        self.imageView_2.tag = 1;
        self.imageView_2.userInteractionEnabled = YES;
        tap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(tapAction:)] autorelease];
        [self.imageView_2 addGestureRecognizer:tap];
        self.sourceLabel_2.text = cm.source;
        self.priceLabel_2.text = [NSString stringWithFormat:@"￥%@",cm.price];
        labelFontSize = [self.priceLabel_2.text sizeWithFont:self.priceLabel_2.font
                                           constrainedToSize:CGSizeMake(99999, self.priceLabel_2.frame.size.height)
                                               lineBreakMode:self.priceLabel_2.lineBreakMode];
        self.priceLabel_2.frame = CGRectMake(self.priceLabel_2.frame.origin.x,
                                             self.priceLabel_2.frame.origin.y,
                                             labelFontSize.width,
                                             self.priceLabel_2.frame.size.height);
        self.oldPriceLabel_2.text = cm.oldPrice;
        labelFontSize = [self.oldPriceLabel_2.text sizeWithFont:self.oldPriceLabel_2.font
                                                     constrainedToSize:CGSizeMake(99999, self.oldPriceLabel_2.frame.size.height)
                                                         lineBreakMode:self.oldPriceLabel_2.lineBreakMode];
        self.oldPriceLabel_2.frame = CGRectMake(self.priceLabel_2.frame.origin.x+self.priceLabel_2.frame.size.width+2,
                                                self.oldPriceLabel_2.frame.origin.y,
                                                labelFontSize.width,
                                                self.oldPriceLabel_2.frame.size.height);
        self.oldPriceLabel_2.isWithStrikeThrough = YES;
        self.collectLabel_2.text = [NSString stringWithFormat:@"%d人参加",cm.collectCount];
    }
}

-(void)tapAction:(UIGestureRecognizer *)gesture
{
    UIView *v = gesture.view;
    CouponModel *cm = [self.dataList objectAtIndex:v.tag];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f green:40.0f/255.0f blue:53.0f/255.0f alpha:1]];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIViewController *vc = nil;
    switch (cm.promotionType ) {//优惠类型 (1, '优惠活动'), (2, '优惠券'), (3, '团购')
        case 3:
            vc = [[[GroupBuyDetailViewController alloc] initWithNibName:@"GroupBuyDetailViewController" bundle:nil] autorelease];
            break;
        case 2:
            vc = [[[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil] autorelease];
            break;
        case 1:
            vc = [[[MallNewsDetailViewController alloc]initWithNibName:@"MallNewsDetailViewController" bundle:nil]autorelease];
            break;
    }
    
    [vc setCouponModel:cm];
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}

-(void)dealloc
{
    self.titleLabel = nil;
    self.dataList = nil;
    
    self.imageView_1 = nil;
    self.imageView_2 = nil;
    self.titleLabel_1 = nil;
    self.titleLabel_2 = nil;
    self.sourceLabel_1 = nil;
    self.sourceLabel_2 = nil;
    
    self.priceLabel_1 = nil;
    self.oldPriceLabel_1 = nil;
    self.collectLabel_1 = nil;
    
    self.priceLabel_2 = nil;
    self.oldPriceLabel_2 = nil;
    self.collectLabel_2 = nil;
    
    [super dealloc];
}
@end
