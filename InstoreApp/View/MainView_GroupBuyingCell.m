//
//  MainView_ GroupBuyingCell.m
//  InstoreApp
//
//  Created by evil on 14-6-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_GroupBuyingCell.h"
#import "CouponModel.h"

@implementation MainView_GroupBuyingCell

- (void)awakeFromNib
{
    // Initialization code
    [self setBorder:self.imageView_1];
    [self setBorder:self.imageView_2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)moreBtnAction:(id)sender
{
    
}

-(void)setDataList:(NSArray *)dataList
{
    [_dataList release];
    _dataList = [dataList retain];
    
    if (self.dataList.count == 2) {
        CouponModel *cm = [self.dataList objectAtIndex:0];
        self.titleLabel_1.text = cm.title;
        self.imageView_1.imageURL = [NSURL URLWithString:cm.imageUrl];
        self.sourceLabel_1.text = cm.source;
        
        cm = [self.dataList objectAtIndex:1];
        self.titleLabel_2.text = cm.title;
        self.imageView_2.imageURL = [NSURL URLWithString:cm.imageUrl];
        self.sourceLabel_2.text = cm.source;
    }
}

-(void)dealloc
{
    self.titleLabel = nil;
    self.dataList = nil;
    
    self.imageView_1 = nil;
    self.imageView_2 = nil;
    self.titleLabel_1 = nil;
    self.titleLabel_2 = nil;
    self.sourceLabel_1 = nil;
    self.sourceLabel_2 = nil;
    
    [super dealloc];
}
@end
