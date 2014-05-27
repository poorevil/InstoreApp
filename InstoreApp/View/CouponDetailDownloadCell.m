//
//  CouponDetailDownloadCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDetailDownloadCell.h"

@implementation CouponDetailDownloadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    self.favNumLabel = nil;
    self.downloadNumLabel = nil;
    
    [super dealloc];
}

@end
