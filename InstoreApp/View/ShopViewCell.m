//
//  ShopViewCell.m
//  InstoreApp
//
//  Created by han chao on 14-3-30.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopViewCell.h"
#import "EGOImageView.h"
#import "StoreModel.h"
#import "FloorModel.h"
#import "CategoryModel.h"
#import "PositionModel.h"
#import "BuildingModel.h"

@implementation ShopViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStoreModel:(StoreModel *)storeModel
{
    _storeModel = storeModel;
    
    self.shopIconImageView.imageURL = [NSURL URLWithString:self.storeModel.logoUrl];
    self.titleLabel.text = self.storeModel.title;
    self.typeLabel.text = self.storeModel.categoryModel.cName;
    self.floorLabel.text = [NSString stringWithFormat:@"%@ %@",self.storeModel.position.building.name, self.storeModel.position.floor.fName];
    self.favLabel.text = [NSString stringWithFormat:@"%d",self.storeModel.followerCount];
}

-(void)dealloc
{
    self.shopIconImageView = nil;
    self.titleLabel = nil;
    self.typeLabel = nil;
    self.floorLabel = nil;
    self.favLabel = nil;
    self.storeModel = nil;
    
    [super dealloc];
}

@end
