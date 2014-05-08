//
//  ShopDetailLocationCell.h
//  InstoreApp
//
//  Created by han chao on 14-4-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreModel;

@interface ShopDetailLocationCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *telLabel;
@property (nonatomic,strong) IBOutlet UILabel *floorLabel;

@property (nonatomic,strong) StoreModel *storeModel;

@end
