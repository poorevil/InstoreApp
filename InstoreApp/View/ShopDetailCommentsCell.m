//
//  ShopDetailCommentsCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopDetailCommentsCell.h"

@implementation ShopDetailCommentsCell

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
    self.storeModel = nil;
    
    [super dealloc];
}

@end
