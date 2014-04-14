//
//  ShopDetailItemListCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopDetailItemListCell.h"

@implementation ShopDetailItemListCell

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
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:248.0f/255.0f
                                                                     green:40.0f/255.0f
                                                                      blue:53.0f/255.0f
                                                                     alpha:1];
    
    [self initScrollView];
}


-(void)initScrollView
{
    self.mscrollView.contentSize = CGSizeMake(self.bounds.size.width * 2, 75);
    self.mscrollView.pagingEnabled = YES;
    
    for (int i = 0; i < 8; i++) {
        UIImageView *imageview = [[UIImageView alloc]
                                  initWithImage:[UIImage
                                                 imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"tmpimg%d",i] ofType:@"jpg"]]];
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.frame = CGRectMake(i*78+10 + (i/4*6),
                                     5, 70, 70);
        [self.mscrollView addSubview:imageview];
    }
}

@end
