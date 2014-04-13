//
//  MainViewNavigationCell.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewNavigationCell.h"

@implementation MainViewNavigationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [self setBtnStyle:self.foodBtn];
    [self setBtnStyle:self.cardBtn];
    [self setBtnStyle:self.orderBtn];
    [self setBtnStyle:self.saleBtn];
    
    
//    UIImage *originalImage = [UIImage imageNamed:@"index-mid-btn-quick-pressed"];
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 6, 300);
    UIImage *pressedBg = [UIImage imageNamed:@"index-mid-btn-quick-pressed"];//[originalImage resizableImageWithCapInsets:insets];
    
//    originalImage = [UIImage imageNamed:@"index-mid-btn-quick"];
    UIImage *normalBg = [UIImage imageNamed:@"index-mid-btn-quick"];//[originalImage resizableImageWithCapInsets:insets];
    
    [self.wifiBtn setBackgroundImage:normalBg forState:UIControlStateNormal];
    [self.mapBtn setBackgroundImage:normalBg forState:UIControlStateNormal];
    
    [self.wifiBtn setBackgroundImage:pressedBg forState:UIControlStateSelected];
    [self.wifiBtn setBackgroundImage:pressedBg forState:UIControlStateHighlighted];
    [self.mapBtn setBackgroundImage:pressedBg forState:UIControlStateSelected];
    [self.mapBtn setBackgroundImage:pressedBg forState:UIControlStateHighlighted];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - private method
-(void)setBtnStyle:(UIButton *)btn
{
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                          (btn.frame.size.width-btn.imageView.frame.size.width)/2-5,
                                          (btn.frame.size.height-btn.imageView.frame.size.height)/2 +5,
                                          0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height +5,
                                          -btn.imageView.frame.size.width,
                                          0, 0)];
    
//    btn.backgroundColor = [UIColor blackColor];
}

@end
