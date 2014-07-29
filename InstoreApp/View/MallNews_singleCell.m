//
//  MallNews_singleCell.m
//  InstoreApp
//
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNews_singleCell.h"
#import "NSDate+DynamicDateString.h"
#import "EGOImageView.h"
//#import "CouponModel.h"
#import "MallNewsModel.h"

@implementation MallNews_singleCell

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
    MallNewsModel *mnm = [[self.dict objectForKey:@"articles"] objectAtIndex:0];
    self.titleLabel.text = mnm.title;
    self.articleDateLabel.text = [mnm.date toDateString];
    self.summaryLabel.text = mnm.summary;
    self.articleImageView.imageURL = [NSURL URLWithString:mnm.image];
}

-(void)dealloc
{
    self.dateLabel = nil;
    self.titleLabel = nil;
    self.articleDateLabel = nil;
    self.summaryLabel = nil;
    self.articleImageView = nil;
    self.parentView = nil;
    
    [super dealloc];
}

@end
