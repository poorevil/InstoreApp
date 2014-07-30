//
//  GroupBuyDetailPriceCell.m
//  InstoreApp
//
//  Created by evil on 14-6-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "GroupBuyDetailPriceCell.h"

@implementation GroupBuyDetailPriceCell

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
    self.priceLabel = nil;
    self.oldPriceLabel = nil;
    self.amountLabel = nil;
    
    [super dealloc];
}

@end
