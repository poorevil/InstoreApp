//
//  StoreList_headerView.m
//  InstoreApp
//
//  Created by evil on 14-6-24.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreList_headerView.h"

@implementation StoreList_headerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.floorBtn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                             self.floorBtn.frame.size.width-8,
                                             0,0)];
    [self.categoryBtn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                                       self.categoryBtn.frame.size.width-8,
                                                       0,0)];
    [self.orderBtn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                                       self.orderBtn.frame.size.width-8,
                                                       0,0)];
}

-(void)hideFilterView:(BOOL)state
{
    if (state) {
        self.filterParentView.hidden = YES;
        self.frame = CGRectMake(0, 0, self.frame.size.width, 52);
        self.line.frame = CGRectMake(0, 52, self.line.frame.size.width, self.line.frame.size.height);
    }else{
        self.filterParentView.hidden = NO;
        self.frame = CGRectMake(0, 0, self.frame.size.width, 85);
        self.line.frame = CGRectMake(0, 85, self.line.frame.size.width, self.line.frame.size.height);
    }
}

-(void)dealloc
{
    self.segmentControl = nil;
    self.filterParentView = nil;
    self.floorBtn = nil;
    self.orderBtn = nil;
    self.categoryBtn = nil;
    
    [super dealloc];
}

@end
