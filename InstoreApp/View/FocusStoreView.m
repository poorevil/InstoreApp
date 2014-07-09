//
//  FocusStoreView.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusStoreView.h"

@implementation FocusStoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}
- (void)awakeFromNib
{
    // Initialization code
    self.storeIogo.layer.masksToBounds = YES;
    self.storeIogo.layer.cornerRadius = 12.0;
    self.storeIogo.layer.borderWidth = 1.0;
    self.storeIogo.layer.borderColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1].CGColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_storeIogo release];
    [_isFocusImage release];
    [_labStoreName release];
    [super dealloc];
}
@end
