//
//  MallNewsDetail_twoCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsDetail_twoCell.h"

@implementation MallNewsDetail_twoCell

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
    [_labDate release];
    [super dealloc];
}
@end
