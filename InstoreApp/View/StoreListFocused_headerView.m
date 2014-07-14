//
//  StoreListFocused_headerView.m
//  InstoreApp
//
//  Created by evil on 14-7-14.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreListFocused_headerView.h"

@implementation StoreListFocused_headerView

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
    
    [self.categoryBtn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                                          self.categoryBtn.frame.size.width-8,
                                                          0,0)];
    [self.orderBtn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                                       self.orderBtn.frame.size.width-8,
                                                       0,0)];
}

-(void)dealloc
{
    self.orderBtn = nil;
    self.categoryBtn = nil;
    
    [super dealloc];
}

@end
