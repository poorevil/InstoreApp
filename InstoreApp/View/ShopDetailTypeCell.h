//
//  ShopDetailTypeCell.h
//  InstoreApp
//
//  Created by han chao on 14-4-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreModel;
@interface ShopDetailTypeCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *categoryLabel;
@property (nonatomic,strong) IBOutlet UILabel *priceLabel;

@property (nonatomic,strong) StoreModel *storeModel;
@end
