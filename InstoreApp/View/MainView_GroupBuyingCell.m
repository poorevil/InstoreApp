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
        CGSize labelFontSize = [self.priceLabel_1.text sizeWithFont:self.priceLabel_1.font
                                              constrainedToSize:CGSizeMake(99999, self.priceLabel_1.frame.size.height)
                                                  lineBreakMode:self.priceLabel_1.lineBreakMode];
        self.priceLabel_1.frame = CGRectMake(self.priceLabel_1.frame.origin.x,
                                                self.priceLabel_1.frame.origin.y,
                                                labelFontSize.width,
                                                self.priceLabel_1.frame.size.height);
        
        self.oldPriceLabel_1.text = cm.oldPrice;
        labelFontSize = [self.oldPriceLabel_1.text sizeWithFont:self.oldPriceLabel_1.font
                                                     constrainedToSize:CGSizeMake(99999, self.oldPriceLabel_1.frame.size.height)
                                                         lineBreakMode:self.oldPriceLabel_1.lineBreakMode];
        self.oldPriceLabel_1.frame = CGRectMake(self.priceLabel_1.frame.origin.x+self.priceLabel_1.frame.size.width+2,
                                                self.oldPriceLabel_1.frame.origin.y,
                                                labelFontSize.width,
                                                self.oldPriceLabel_1.frame.size.height);
        self.oldPriceLabel_1.isWithStrikeThrough = YES;
        self.collectLabel_1.text = [NSString stringWithFormat:@"%d人参加",cm.collectCount];
        
        cm = [self.dataList objectAtIndex:1];
        self.titleLabel_2.text = cm.title;
        self.imageView_2.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/300*300.png",cm.imageUrl]];
        self.sourceLabel_2.text = cm.source;
        self.priceLabel_2.text = [NSString stringWithFormat:@"￥%@",cm.price];
        labelFontSize = [self.priceLabel_2.text sizeWithFont:self.priceLabel_2.font
                                           constrainedToSize:CGSizeMake(99999, self.priceLabel_2.frame.size.height)
                                               lineBreakMode:self.priceLabel_2.lineBreakMode];
        self.priceLabel_2.frame = CGRectMake(self.priceLabel_2.frame.origin.x,
                                             self.priceLabel_2.frame.origin.y,
                                             labelFontSize.width,
                                             self.priceLabel_2.frame.size.height);
        self.oldPriceLabel_2.text = cm.oldPrice;
        labelFontSize = [self.oldPriceLabel_2.text sizeWithFont:self.oldPriceLabel_2.font
                                                     constrainedToSize:CGSizeMake(99999, self.oldPriceLabel_2.frame.size.height)
                                                         lineBreakMode:self.oldPriceLabel_2.lineBreakMode];
        self.oldPriceLabel_2.frame = CGRectMake(self.priceLabel_2.frame.origin.x+self.priceLabel_2.frame.size.width+2,
                                                self.oldPriceLabel_2.frame.origin.y,
                                                labelFontSize.width,
                                                self.oldPriceLabel_2.frame.size.height);
        self.oldPriceLabel_2.isWithStrikeThrough = YES;
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
