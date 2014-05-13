//
//  ShopDetailHeaderView.h
//  InstoreApp
//
//  Created by hanchao on 14-4-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreModel;
@class EGOImageView;
@interface ShopDetailHeaderView : UIView

@property (nonatomic,strong) StoreModel *storeModel;

@property (nonatomic,strong) IBOutlet EGOImageView *bannerImageView;
@property (nonatomic,strong) IBOutlet EGOImageView *logoImageView;

@end
