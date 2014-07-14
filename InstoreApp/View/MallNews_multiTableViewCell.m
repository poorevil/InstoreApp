//
//  MallNews_multiTableViewCell.m
//  InstoreApp
//
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNews_multiTableViewCell.h"
#import "EGOImageView.h"
#import "NSDate+DynamicDateString.h"
#import "CouponModel.h"


@implementation MallNews_multiTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.parentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.parentView.layer.borderWidth = 0.4f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDict:(NSDictionary *)dict
{
    [_dict release];
    _dict = [dict retain];
    
    NSString *dateStr = [self.dict objectForKey:@"date"];
    self.dateLabel.text = dateStr == nil?@"":[[NSDate dateFromString:dateStr] toDateString];
    
    CouponModel *mnm = [[self.dict objectForKey:@"articles"] objectAtIndex:0];
    self.titleLabel_1.text = mnm.title;
    self.articleImageView_1.imageURL = [NSURL URLWithString:mnm.imageUrl];
    
    if ([[self.dict objectForKey:@"articles"] count] >1) {
        mnm = [[self.dict objectForKey:@"articles"] objectAtIndex:1];
        self.titleLabel_2.text = mnm.title;
        self.articleImageView_2.imageURL = [NSURL URLWithString:mnm.imageUrl];
    }
    
    if ([[self.dict objectForKey:@"articles"] count] >2) {
        mnm = [[self.dict objectForKey:@"articles"] objectAtIndex:2];
        self.titleLabel_3.text = mnm.title;
        self.articleImageView_3.imageURL = [NSURL URLWithString:mnm.imageUrl];
    }
}

-(void)dealloc
{
    self.dateLabel = nil;
    self.articleImageView_1 = nil;
    self.titleLabel_1 = nil;
    self.articleImageView_2 = nil;
    self.titleLabel_2 = nil;
    self.articleImageView_3 = nil;
    self.titleLabel_3 = nil;
    self.parentView = nil;
    
    [super dealloc];
}

@end
