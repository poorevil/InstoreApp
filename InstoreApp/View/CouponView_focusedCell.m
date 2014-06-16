//
//  CouponView_focusedCell.m
//  InstoreApp
//
//  Created by evil on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponView_focusedCell.h"
#import "CouponModel.h"
#import "CouponView_empty_tileView.h"
#import "CouponView_focused_tileView.h"
#import "CouponDetailViewController.h"
#import "AppDelegate.h"
#import "GroupBuyDetailViewController.h"

@implementation CouponView_focusedCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCm1:(CouponModel *)cm1
{
    [_cm1 release];
    _cm1 = [cm1 retain];
    
    [self.leftView removeFromSuperview];
    
    if (self.cm1) {
        CouponView_focused_tileView *view = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focused_tileView" owner:self options:nil] objectAtIndex:0];
        view.cm = self.cm1;
        view.frame = CGRectMake(5, 5, view.frame.size.width, view.frame.size.height);
        view.parentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.parentView.layer.borderWidth = 0.4f;
        [self addSubview:view];
        
        self.leftView = view;
        
        view.tag = 1;
        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)] autorelease];
        [view addGestureRecognizer:tap];
    }
    
}

-(void)setCm2:(CouponModel *)cm2
{
    [_cm2 release];
    _cm2 = [cm2 retain];
    
    [self.rightView removeFromSuperview];
    
    if (self.cm1) {
        if (self.cm2) {
            CouponView_focused_tileView *view = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focused_tileView" owner:self options:nil] objectAtIndex:0];
            view.userInteractionEnabled = YES;
            view.cm = self.cm2;
            view.frame = CGRectMake(163, 5, view.frame.size.width, view.frame.size.height);
            view.parentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            view.parentView.layer.borderWidth = 0.4f;
            view.tag = 2;
            
            self.rightView = view;
            
            UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)] autorelease];
            [view addGestureRecognizer:tap];
            
            
            [self addSubview:view];
        }else{
            //添加CouponView_empty_tileView
            CouponView_empty_tileView *view = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_empty_tileView" owner:self options:nil] objectAtIndex:0];
            view.userInteractionEnabled = YES;
            view.frame = CGRectMake(163, 5, view.frame.size.width, view.frame.size.height);
            view.layer.borderColor = [UIColor lightGrayColor].CGColor;
            view.layer.borderWidth = 0.4f;
            view.tag = 2;
            
            self.rightView = view;
            
            UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)] autorelease];
            [view addGestureRecognizer:tap];
            
            [self addSubview:view];
        }
    }else{
        //不添加任何view
    }
    
}

-(void)tapAction:(UIGestureRecognizer *)gesture
{
    UIView *v = gesture.view;
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    
    UIViewController *vc = nil;
    CouponModel *cm = v.tag==1?self.cm1:self.cm2;
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
    self.cm1 = nil;
    self.cm2 = nil;
    self.leftView = nil;
    self.rightView = nil;
    
    [super dealloc];
}

@end
