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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc
{
    self.segmentControl = nil;
    
    [super dealloc];
}

@end
