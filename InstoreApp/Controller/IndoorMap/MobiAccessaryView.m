//
//  MobiDoubleLinesAccessaryView.m
//  SmartMall
//
//  Created by dujianping on 12/25/11.
//  Copyright (c) 2011 __www.widitu.net__. All rights reserved.
//

#import "MobiAccessaryView.h"

#define FIRST_LINE_IMAGEVIEW_WIDTH          14
#define FIRST_LINE_IMAGEVIEW_HEIGHT         14
#define SECOND_LINE_IMAGEVIEW_WIDTH         14
#define SECOND_LINE_IMAGEVIEW_HEIGHT        14

@implementation MobiAccessaryView

@synthesize firstLineTextLabel, firstLineImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *aLabel = [[UILabel alloc] init];
        aLabel.backgroundColor = [UIColor clearColor];
        aLabel.font = [UIFont systemFontOfSize: 12.0];
        aLabel.textAlignment = NSTextAlignmentCenter;
        aLabel.contentMode = UIViewContentModeCenter;
        aLabel.textColor = [UIColor colorWithRed:52.0/255 green:139.0/255 blue:206.0/255 alpha:1];
        self.firstLineTextLabel = aLabel;
        [aLabel release];
        [self addSubview:self.firstLineTextLabel];
        
        UIImageView *aImageView = [[UIImageView alloc] init];
        aImageView.backgroundColor = [UIColor clearColor];
        self.firstLineImageView = aImageView;
        [aImageView release];
        [self addSubview:firstLineImageView];
    }
    return self;
}

-(void)layoutSubviews
{
    CGRect frame = self.frame;
    CGFloat margin_x = 5;
    UIFont *cellFont = [UIFont systemFontOfSize:12.0];
    CGSize constraintSize = CGSizeMake(200.0f, MAXFLOAT);
    CGSize firstLineTextLabelSize = [firstLineTextLabel.text sizeWithFont:cellFont 
                                               constrainedToSize:constraintSize 
                                                   lineBreakMode:NSLineBreakByWordWrapping];
    CGRect firstLineLabelFrame = CGRectZero;
    firstLineLabelFrame.size.width = firstLineTextLabelSize.width;
    firstLineLabelFrame.size.height = firstLineTextLabelSize.height;
    firstLineLabelFrame.origin.x = frame.size.width - firstLineLabelFrame.size.width - 2 * margin_x;
    [firstLineTextLabel setFrame:firstLineLabelFrame];
    
    if (firstLineImageView.image) {
        CGFloat firstImageView_x = firstLineLabelFrame.origin.x - FIRST_LINE_IMAGEVIEW_HEIGHT - margin_x;
        CGFloat firstImageView_y = firstLineLabelFrame.origin.y - (SECOND_LINE_IMAGEVIEW_HEIGHT - firstLineTextLabelSize.height) / 2;
        [firstLineImageView setFrame:CGRectMake(firstImageView_x, firstImageView_y, FIRST_LINE_IMAGEVIEW_WIDTH, FIRST_LINE_IMAGEVIEW_HEIGHT)];
    }
    
    //NSLog(@"Second ImageView frame = %@", NSStringFromCGRect(secondLineImageView.frame));
}

-(CGSize)getAccessaryViewSize
{
    UIFont *cellFont = [UIFont systemFontOfSize:12.0];
    CGSize constraintSize = CGSizeMake(200.0f, MAXFLOAT);
    
    
    CGFloat lineOneWidth = 0;
    CGFloat lineTwoWidth = 0;
    CGFloat lineOneHeight = 0;
    CGFloat lineTwoHeight = 0;
    CGFloat margin_x = 5;
    if (self.firstLineImageView.image) {
        lineOneWidth += FIRST_LINE_IMAGEVIEW_WIDTH + margin_x;
        lineOneHeight += FIRST_LINE_IMAGEVIEW_HEIGHT;
    }
    
    if (self.firstLineTextLabel.text) {
        CGSize firstLineTextLabelSize = [firstLineTextLabel.text sizeWithFont:cellFont 
                                                            constrainedToSize:constraintSize 
                                                                lineBreakMode:NSLineBreakByWordWrapping];
        lineOneWidth += firstLineTextLabelSize.width;
        lineOneHeight = MAX(lineOneHeight, firstLineTextLabelSize.height);
    }
    
    CGSize size = CGSizeMake(MAX(lineOneWidth, lineTwoWidth), lineOneHeight + lineTwoHeight);
    return size;
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
    [firstLineTextLabel release];
    [firstLineImageView release];
    
    [super dealloc];
}

@end
