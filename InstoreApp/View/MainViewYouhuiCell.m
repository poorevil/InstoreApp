//
//  MainViewYouhuiCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewYouhuiCell.h"

@implementation MainViewYouhuiCell

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

-(void)awakeFromNib
{
    UIImage *originalImage = [UIImage imageNamed:@"index-red-btn"];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 6, 300);
    UIImage *btnBg = [originalImage resizableImageWithCapInsets:insets];
    
    [self.moreBtn setBackgroundImage:btnBg forState:UIControlStateNormal];
    [self.moreBtn setBackgroundImage:btnBg forState:UIControlStateHighlighted];
    [self.moreBtn setBackgroundImage:btnBg forState:UIControlStateSelected];
}
@end
