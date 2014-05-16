//
//  ShopDetailDescriptionCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopDetailDescriptionCell.h"

@implementation ShopDetailDescriptionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.isShowDetailMessage = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)moreBtnAction:(id)sender
{
    self.isShowDetailMessage = !self.isShowDetailMessage;
    
    if ([self.delegate respondsToSelector:@selector(isShowDetailMessage:)]) {
        [self.delegate isShowDetailMessage:self.isShowDetailMessage];
    }
}

@end
