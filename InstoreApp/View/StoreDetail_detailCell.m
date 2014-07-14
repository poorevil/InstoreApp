//
//  StoreDetail_detailCell.m
//  InstoreApp
//
//  Created by evil on 14-6-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreDetail_detailCell.h"
#import "StoreDetail_RestaurantViewController.h"

@implementation StoreDetail_detailCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    self.detailLabel = nil;
    self.slideUpBtn = nil;
    
    [super dealloc];
}

-(IBAction)slideUpBtnAction:(id)sender
{
    CGFloat diff = 0;
    
    if (self.detailLabel.frame.size.height != 60) {
        self.detailLabel.frame = CGRectMake(self.detailLabel.frame.origin.x,
                                            self.detailLabel.frame.origin.y,
                                            self.detailLabel.frame.size.width,
                                            60);
        self.detailLabel.numberOfLines = 3;
        
        diff = 60 - self.detailLabel.frame.size.height;
        
    }else{
        CGSize labelFontSize = [self.detailLabel.text sizeWithFont:[UIFont systemFontOfSize:14]
                                                 constrainedToSize:CGSizeMake(300, 999)
                                                     lineBreakMode:NSLineBreakByWordWrapping];

        diff = labelFontSize.height - self.detailLabel.frame.size.height;
        
        self.detailLabel.frame = CGRectMake(self.detailLabel.frame.origin.x,
                                            self.detailLabel.frame.origin.y,
                                            labelFontSize.width,
                                            labelFontSize.height);
        self.detailLabel.numberOfLines = 99;
    }
    
    self.slideUpBtn.frame = CGRectMake(self.slideUpBtn.frame.origin.x,
                                       self.slideUpBtn.frame.origin.y + diff,
                                       self.slideUpBtn.frame.size.width,
                                       self.slideUpBtn.frame.size.height);
    
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height + diff);
    
    if ([self.delegate isMemberOfClass:[StoreDetail_RestaurantViewController class]]) {
//        self.delegate.detailCellHeight = self.frame.size.height;
//        [self.delegate.mtableView reloadData];
    }
}

@end
