//
//  MainView_ CouponsCell.m
//  InstoreApp
//
//  Created by evil on 14-6-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_CouponsCell.h"
#import "CouponModel.h"

@implementation MainView_CouponsCell

- (void)awakeFromNib
{
    // Initialization code
    [self setBorder:self.imageView_1];
    [self setBorder:self.imageView_2];
    [self setBorder:self.imageView_3];
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
    
    if (self.dataList.count == 3) {
        CouponModel *cm = [self.dataList objectAtIndex:0];
        self.titleLabel_1.text = cm.title;
        self.imageView_1.imageURL = [NSURL URLWithString:cm.imageUrl];
        
        cm = [self.dataList objectAtIndex:1];
        self.titleLabel_2.text = cm.title;
        self.imageView_2.imageURL = [NSURL URLWithString:cm.imageUrl];
        
        cm = [self.dataList objectAtIndex:2];
        self.titleLabel_3.text = cm.title;
        self.imageView_3.imageURL = [NSURL URLWithString:cm.imageUrl];
    }
}

-(void)dealloc
{
    self.titleLabel = nil;
    self.dataList = nil;
    
    self.imageView_1 = nil;
    self.imageView_2 = nil;
    self.imageView_3 = nil;
    self.titleLabel_1 = nil;
    self.titleLabel_2 = nil;
    self.titleLabel_3 = nil;
    
    [super dealloc];
}
@end
