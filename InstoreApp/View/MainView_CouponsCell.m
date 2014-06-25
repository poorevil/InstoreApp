//
//  MainView_ CouponsCell.m
//  InstoreApp
//
//  Created by evil on 14-6-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_CouponsCell.h"
#import "CouponModel.h"

#import "AppDelegate.h"
#import "GroupBuyDetailViewController.h"
#import "CouponDetailViewController.h"

@implementation MainView_CouponsCell

- (void)awakeFromNib
{
    // Initialization code
    [self setBorder:self.imageView_1];
    [self setBorder:self.imageView_2];
    [self setBorder:self.imageView_3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)moreBtnAction:(id)sender
{
    
}

-(void)setDataList:(NSArray *)dataList
{
    [_dataList release];
    _dataList = [dataList retain];
    
    if (self.dataList.count == 3) {
        CouponModel *cm = [self.dataList objectAtIndex:0];
        self.titleLabel_1.text = cm.title;
        self.imageView_1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/300*300.png",cm.imageUrl]];
        self.imageView_1.tag = 0;
        self.imageView_1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(tapAction:)] autorelease];
        [self.imageView_1 addGestureRecognizer:tap];
        
        cm = [self.dataList objectAtIndex:1];
        self.titleLabel_2.text = cm.title;
        self.imageView_2.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",cm.imageUrl]];
        self.imageView_2.tag = 1;
        self.imageView_2.userInteractionEnabled = YES;
        tap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(tapAction:)] autorelease];
        [self.imageView_2 addGestureRecognizer:tap];
        
        cm = [self.dataList objectAtIndex:2];
        self.titleLabel_3.text = cm.title;
        self.imageView_3.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",cm.imageUrl]];
        self.imageView_3.tag = 2;
        self.imageView_3.userInteractionEnabled = YES;
        tap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                       action:@selector(tapAction:)] autorelease];
        [self.imageView_3 addGestureRecognizer:tap];
    }
}

-(void)tapAction:(UIGestureRecognizer *)gesture
{
    UIView *v = gesture.view;
    CouponModel *cm = [self.dataList objectAtIndex:v.tag];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    
    UIViewController *vc = nil;
    switch (cm.promotionType ) {//优惠类型 (1, '优惠活动'), (2, '优惠券'), (3, '团购')
        case 3:
            vc = [[[GroupBuyDetailViewController alloc] initWithNibName:@"GroupBuyDetailViewController" bundle:nil] autorelease];
            break;
        case 2:
            vc = [[[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil] autorelease];
            break;
            //TODO:case2
            
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
    self.imageView_3 = nil;
    self.titleLabel_1 = nil;
    self.titleLabel_2 = nil;
    self.titleLabel_3 = nil;
    
    [super dealloc];
}
@end
