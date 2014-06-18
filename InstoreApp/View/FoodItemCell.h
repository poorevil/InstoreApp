//
//  FoodItemCell.h
//  InstoreApp
//
//  Created by evil on 14-6-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EGOImageView;
@class StoreModel;

@interface FoodItemCell : UITableViewCell

@property (nonatomic, retain) IBOutlet EGOImageView *logoImageView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *subTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UILabel *favorLabel;

@property (nonatomic, retain) StoreModel *storeModel;

@end
