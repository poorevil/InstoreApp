//
//  MainViewYouhuiCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewYouhuiCell.h"
#import "AppDelegate.h"

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
//    UIImage *btnBg = [UIImage imageNamed:@"index-red-btn"];
//    [self.moreBtn setBackgroundImage:btnBg forState:UIControlStateNormal];
//    [self.moreBtn setBackgroundImage:btnBg forState:UIControlStateHighlighted];
//    [self.moreBtn setBackgroundImage:btnBg forState:UIControlStateSelected];
    
    [self.moreBtn addTarget:self action:@selector(moreBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];
}

-(void)moreBtnAction:(id)sender
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.tabBarController setSelectedIndex:1];
}
@end
