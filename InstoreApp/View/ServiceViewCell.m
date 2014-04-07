//
//  ServiceViewCell.m
//  InstoreApp
//
//  Created by han chao on 14-3-30.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ServiceViewCell.h"

@implementation ServiceViewCell

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
    [self setBtnStyle:self.busBtn];
    [self setBtnStyle:self.moneyBtn];
    [self setBtnStyle:self.planeBtn];
    [self setBtnStyle:self.paintBtn];
    [self setBtnStyle:self.gameBtn];
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
                                             (btn.frame.size.width-btn.imageView.frame.size.width)/2,
                                             (btn.frame.size.height-btn.imageView.frame.size.height)/2 +5,
                                             0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height +5,
                                             -btn.imageView.frame.size.width,
                                             0, 0)];
    
    //    btn.backgroundColor = [UIColor blackColor];
}

@end
