//
//  StoreDetail_RestaurantViewController.h
//  InstoreApp
//  商铺详细页面--餐饮
//  Created by evil on 14-6-20.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDetail_RestaurantViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *mtableView;
@property (nonatomic,assign) NSInteger shopId;

@end
