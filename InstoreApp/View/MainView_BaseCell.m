//
//  MainView_BaseCell.m
//  InstoreApp
//
//  Created by evil on 14-6-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_BaseCell.h"

@implementation MainView_BaseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBorder:(UIView *)childView
{
    if (childView) {
        childView.superview.layer.borderWidth = 0.4f;
        childView.superview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

@end
