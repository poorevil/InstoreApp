//
//  MallNewsDetail_threeCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsDetail_threeCell.h"

@implementation MallNewsDetail_threeCell

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
    [_iconImage release];
    [_labClass release];
    [_labName release];
    [_img release];
    [super dealloc];
}
@end
