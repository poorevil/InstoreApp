//
//  ShopDetailTypeCell.m
//  InstoreApp
//
//  Created by han chao on 14-4-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopDetailTypeCell.h"
#import "StoreModel.h"
#import "CategoryModel.h"

@implementation ShopDetailTypeCell

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
    self.categoryLabel.text = self.storeModel.categoryModel.cName;
    //TODO:人均
}

-(void)dealloc
{
    self.categoryLabel = nil;
    self.priceLabel = nil;
    self.storeModel = nil;
    
    [super dealloc];
}
@end
