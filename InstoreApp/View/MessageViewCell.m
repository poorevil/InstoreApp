//
//  MessageViewCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MessageViewCell.h"

@implementation MessageViewCell

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
    [_labTitle release];
    [_labDate release];
    [_labDescription release];
    [super dealloc];
}
@end
