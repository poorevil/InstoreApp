//
//  ShopDetailItemListCell.h
//  InstoreApp
//
//  Created by han chao on 14-4-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "StoreModel.h"
@interface ShopDetailItemListCell : UITableViewCell <UIScrollViewDelegate>

@property (nonatomic,strong) IBOutlet UIScrollView *mscrollView;
@property (nonatomic,strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic,strong) StoreModel *storeModel;
@end
