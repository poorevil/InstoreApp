//
//  BankCardCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BankCardCell.h"

@implementation BankCardCell

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
    [_bankImageIcon release];
    [_labBankName release];
    [_labDiscountCount release];
    [_labSlogan release];
    [_imgGoNext release];
    [super dealloc];
}
@end
