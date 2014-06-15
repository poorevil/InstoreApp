//
//  GroupBuyDetailCardCell.m
//  InstoreApp
//
//  Created by evil on 14-6-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "GroupBuyDetailCardCell.h"

@implementation GroupBuyDetailCardCell

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
    self.cardsLabel = nil;
    [super dealloc];
}
@end
