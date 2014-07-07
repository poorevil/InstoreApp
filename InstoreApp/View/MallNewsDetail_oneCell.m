//
//  MallNewsDetail_oneCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsDetail_oneCell.h"

@implementation MallNewsDetail_oneCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc{
    self.titleLabel = nil;
    self.favNumLabel = nil;
    
    [super dealloc];
}

@end
