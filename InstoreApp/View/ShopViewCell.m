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
    self.typeLabel.text = [NSString stringWithFormat:@"%d",self.storeModel.categoryId];
    self.floorLabel.text = self.storeModel.floor;
    self.favLabel.text = [NSString stringWithFormat:@"%d",self.storeModel.followerCount];
}

@end
