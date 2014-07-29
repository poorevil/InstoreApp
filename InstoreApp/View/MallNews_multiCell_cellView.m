//
//  MallNews_multiCell_cellView.m
//  InstoreApp
//
//  Created by Mac on 14-7-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNews_multiCell_cellView.h"


@implementation MallNews_multiCell_cellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc{
    self.articleImageView = nil;
    self.titleLabel = nil;
    self.url = nil;
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
