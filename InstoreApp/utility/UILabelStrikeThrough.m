//
//  UILabelStrikeThrough.m
//  InstoreApp
//
//  Created by hanchao on 14-6-13.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "UILabelStrikeThrough.h"

@implementation UILabelStrikeThrough

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.isWithStrikeThrough)
    {
        CGContextRef c = UIGraphicsGetCurrentContext();
        
        CGFloat black[4] = {0.0f, 0.0f, 0.0f, 1.0f};
        CGContextSetStrokeColor(c, black);
        CGContextSetLineWidth(c, 0.5f);
        CGContextBeginPath(c);
        CGFloat halfWayUp = (self.bounds.size.height - self.bounds.origin.y) / 2.0;
        CGContextMoveToPoint(c, self.bounds.origin.x, halfWayUp );
        CGContextAddLineToPoint(c, self.bounds.origin.x + self.bounds.size.width, halfWayUp);
        CGContextStrokePath(c);
    }
    
    [super drawRect:rect];
}

- (void)dealloc
{
    [super dealloc];
}

@end
