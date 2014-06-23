//
//  StoreDetail_otherCouponTileView.m
//  InstoreApp
//
//  Created by evil on 14-6-24.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreDetail_otherCouponTileView.h"

#import "EGOImageView.h"
#import "CouponModel.h"

@implementation StoreDetail_otherCouponTileView

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

-(void)setCouponModel:(CouponModel *)couponModel
{
    [_couponModel release];
    _couponModel = [couponModel retain];
    
    self.logoImageVew.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",self.couponModel.imageUrl]];
    self.titleLabel.text = self.couponModel.title;
    self.subtitleLabel.text = self.couponModel.shortTitle;
    self.otherlabel.text = [NSString stringWithFormat:@"已下载%d张",self.couponModel.collectCount];
}


-(void)dealloc
{
    self.logoImageVew = nil;
    self.titleLabel = nil;
    self.subtitleLabel = nil;
    self.otherlabel = nil;
    
    [super dealloc];
}

@end
