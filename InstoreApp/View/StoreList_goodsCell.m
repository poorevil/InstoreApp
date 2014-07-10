//
//  StoreList_goodsCell.m
//  InstoreApp
//
//  Created by evil on 14-6-24.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreList_goodsCell.h"

#import "EGOImageView.h"
#import "StoreModel.h"
#import "PositionModel.h"
#import "FloorModel.h"

@implementation StoreList_goodsCell

- (void)awakeFromNib
{
    // Initialization code
    self.logoImageView.layer.borderWidth = 0.4f;
    self.logoImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStoreModel:(StoreModel *)storeModel
{
    [_storeModel release];
    _storeModel = [storeModel retain];
    
    self.logoImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/100*100.png",self.storeModel.logoUrl]];
    self.titleLabel.text = self.storeModel.title;
    //TODO:tag!!
    self.addressLabel.text = self.storeModel.position.floor.fName;
    self.favorLabel.text = [NSString stringWithFormat:@"%d", self.storeModel.followerCount];
}

-(void)dealloc
{
    self.logoImageView = nil;
    self.titleLabel = nil;
    self.addressLabel = nil;
    self.favorLabel = nil;
    
    [super dealloc];
}

@end
