//
//  MainViewOtherCell.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewOtherCell.h"

@implementation MainViewOtherCell

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
    self.titleLabel = nil;
    self.bannerImageView = nil;
    self.title1 = nil;
    self.title1_1 = nil;
    self.title2 = nil;
    self.title2_1 = nil;
    
    [super dealloc];
}

@end
