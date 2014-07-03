//
//  DailyDealViewCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-1.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DailyDealViewCell.h"

@implementation DailyDealViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_title release];
    [_shortTitle release];
    [_imgView release];
    [_summary release];
    [_focusCount release];
    [super dealloc];
}

@end
