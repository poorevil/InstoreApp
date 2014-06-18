//
//  MainView_DailyPromotionCell.m
//  InstoreApp
//
//  Created by evil on 14-6-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_DailyPromotionCell.h"
#import "CouponModel.h"

@implementation MainView_DailyPromotionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

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
        self.imageView_1.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/300*300.png",cm.imageUrl]];
        [self setupTypeLabel:cm.promotionType andTypeLabel:self.typeLabel_1];
        
        cm = [self.dataList objectAtIndex:1];
        self.titleLabel_2.text = cm.title;
        self.imageView_2.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/400*100.png",cm.imageUrl]];
        [self setupTypeLabel:cm.promotionType andTypeLabel:self.typeLabel_2];
        
        cm = [self.dataList objectAtIndex:2];
        self.titleLabel_3.text = cm.title;
        self.imageView_3.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/400*100.png",cm.imageUrl]];
        [self setupTypeLabel:cm.promotionType andTypeLabel:self.typeLabel_3];
    }
}

-(void)setupTypeLabel:(NSInteger)type andTypeLabel:(UILabel *)label
{
    UIColor *bgColor = nil;
    NSString *text = nil;
    switch (type) {
        case 1: //惠
            bgColor = HUI_COLOR;
            text = @"惠";
            break;
        case 2: //券
            bgColor = QUAN_COLOR;
            text = @"券";
            break;
        case 3: //团
            bgColor = TUAN_COLOR;
            text = @"团";
            break;
    }
    
    label.superview.backgroundColor = bgColor;
    label.text = text;
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
    self.typeLabel_1 = nil;
    self.typeLabel_2 = nil;
    self.typeLabel_3 = nil;
    
    [super dealloc];
}
@end
