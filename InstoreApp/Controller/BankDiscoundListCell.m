//
//  BankDiscoundListCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BankDiscoundListCell.h"

@implementation BankDiscoundListCell

- (void)awakeFromNib
{
    // Initialization code
    self.parentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.parentView.layer.borderWidth = 0.4f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_labTitle release];
    [_labBankLogo release];
    [_labStartTime release];
    [_labEndTime release];
    [_imgView release];
    [_imageStoreLogo release];
    [_parentView release];
    [super dealloc];
}
@end
