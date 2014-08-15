//
//  StoreDetail_headerView.m
//  InstoreApp
//
//  Created by evil on 14-6-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreDetail_headerView.h"
#import "StoreModel.h"
#import "EGOImageView.h"
#import "CategoryModel.h"
#import "PositionModel.h"
#import "BuildingModel.h"
#import "FloorModel.h"

@implementation StoreDetail_headerView

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
    [_storeModel release];
    _storeModel = [storeModel retain];
    
    self.logoImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/150*150.png",self.storeModel.logoUrl]];
    self.titleLabel.text = self.storeModel.title;
    self.categoryLabel.text = self.storeModel.categoryModel.cName;
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",self.storeModel.position.floor.fName,self.storeModel.position.roomNum];
    self.telLabel.text = self.storeModel.tel;
    if ([storeModel.appCategory isEqualToString:@"Restaurant"]) {
        self.avgPrice.text = [NSString stringWithFormat:@"人均:%d",storeModel.avgPrice];
    }
}

-(void)dealloc
{
    self.logoImageView = nil;
    self.titleLabel = nil;
    self.categoryLabel = nil;
    self.avgPrice = nil;
    self.addressLabel = nil;
    self.telLabel = nil;
    self.storeModel = nil;
    
    [super dealloc];
}

@end
