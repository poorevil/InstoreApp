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
        self.imageView_1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/300*300.png",cm.imageUrl]];
        self.sourceLabel_1.text = cm.source;
        self.priceLabel_1.text = [NSString stringWithFormat:@"￥%@",cm.price];
        self.oldPriceLabel_1.text = cm.oldPrice;
        self.collectLabel_1.text = [NSString stringWithFormat:@"%d人参加",cm.collectCount];
        
        cm = [self.dataList objectAtIndex:1];
        self.titleLabel_2.text = cm.title;
        self.imageView_2.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/300*300.png",cm.imageUrl]];
        self.sourceLabel_2.text = cm.source;
        self.priceLabel_2.text = [NSString stringWithFormat:@"￥%@",cm.price];
        self.oldPriceLabel_2.text = cm.oldPrice;
        self.collectLabel_2.text = [NSString stringWithFormat:@"%d人参加",cm.collectCount];
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
    
    self.priceLabel_1 = nil;
    self.oldPriceLabel_1 = nil;
    self.collectLabel_1 = nil;
    
    self.priceLabel_2 = nil;
    self.oldPriceLabel_2 = nil;
    self.collectLabel_2 = nil;
    
    [super dealloc];
}
@end
