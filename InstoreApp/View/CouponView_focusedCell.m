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
    
    if (self.cm1) {
        CouponView_focused_tileView *view = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focused_tileView" owner:self options:nil] objectAtIndex:0];
        view.cm = self.cm1;
        view.frame = CGRectMake(5, 5, view.frame.size.width, view.frame.size.height);
        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        view.layer.borderWidth = 0.4f;
        [self addSubview:view];
    }
}

-(void)setCm2:(CouponModel *)cm2
{
    [_cm2 release];
    _cm2 = [cm2 retain];
    
    if (self.cm1) {
        if (self.cm2) {
            CouponView_focused_tileView *view = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focused_tileView" owner:self options:nil] objectAtIndex:0];
            view.cm = self.cm2;
            view.frame = CGRectMake(163, 5, view.frame.size.width, view.frame.size.height);
            view.layer.borderColor = [UIColor lightGrayColor].CGColor;
            view.layer.borderWidth = 0.4f;
            [self addSubview:view];
        }else{
            //添加CouponView_empty_tileView
            CouponView_empty_tileView *view = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_empty_tileView" owner:self options:nil] objectAtIndex:0];
            view.frame = CGRectMake(163, 5, view.frame.size.width, view.frame.size.height);
            view.layer.borderColor = [UIColor lightGrayColor].CGColor;
            view.layer.borderWidth = 0.4f;
            [self addSubview:view];
        }
    }else{
        //不添加任何view
    }
}

-(void)dealloc
{
    self.cm1 = nil;
    self.cm2 = nil;
    [super dealloc];
}

@end
