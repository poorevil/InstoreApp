//
//  CouponView_titleCell.m
//  InstoreApp
//
//  Created by evil on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponView_titleCell.h"

@implementation CouponView_titleCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    self.titleLabel = nil;
    [super dealloc];
}
@end
