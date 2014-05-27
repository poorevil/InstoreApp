//
//  ShopDetailHeaderView.m
//  InstoreApp
//
//  Created by hanchao on 14-4-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopDetailHeaderView.h"
#import "StoreModel.h"
#import "EGOImageView.h"

@implementation ShopDetailHeaderView

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

-(void)setStoreModel:(StoreModel *)storeModel
{
    _storeModel = storeModel;
    
    if (self.storeModel) {
        self.bannerImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/640*256.png",self.storeModel.imageUrl]];
        self.logoImageView.imageURL = [NSURL URLWithString:self.storeModel.logoUrl];
    }
}

-(void)dealloc
{
    self.storeModel = nil;
    self.bannerImageView = nil;
    self.logoImageView = nil;
    
    [super dealloc];
}

@end
