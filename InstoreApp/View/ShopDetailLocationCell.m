//
//  ShopDetailLocationCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopDetailLocationCell.h"
#import "StoreModel.h"
#import "FloorModel.h"
#import "PositionModel.h"

@implementation ShopDetailLocationCell

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
    self.floorLabel.text = self.storeModel.position.floor.fName;
    self.telLabel.text = self.storeModel.tel;
}

@end
