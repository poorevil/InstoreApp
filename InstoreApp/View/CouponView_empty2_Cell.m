//
//  CouponView_empty2_Cell.m
//  InstoreApp
//
//  Created by Mac on 14-7-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponView_empty2_Cell.h"

@implementation CouponView_empty2_Cell

- (void)awakeFromNib
{
    // Initialization code
    self.backGroundView.layer.borderColor = [UIColor colorWithRed:231/255.0 green:210/255.0 blue:210/255.0 alpha:1].CGColor;
    self.backGroundView.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_backGroundView release];
    [super dealloc];
}
- (IBAction)addMyBrand:(UIButton *)sender {
    
}
@end
