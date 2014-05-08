//
//  ShopViewCell.h
//  InstoreApp
//
//  Created by han chao on 14-3-30.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EGOImageView;
@class StoreModel;
@interface ShopViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet EGOImageView *shopIconImageView;
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) IBOutlet UILabel *typeLabel;
@property (nonatomic,strong) IBOutlet UILabel *floorLabel;
@property (nonatomic,strong) IBOutlet UILabel *favLabel;

@property (nonatomic,strong) StoreModel *storeModel;
@end
