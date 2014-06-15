//
//  CouponDetailStoreCell.m
//  InstoreApp
//
//  Created by evil on 14-6-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDetailStoreCell.h"

@implementation CouponDetailStoreCell

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
    self.storeAddrLabel = nil;
    self.storeNameLabel = nil;
    self.storetelLabel = nil;
    
    [super dealloc];
}
@end
