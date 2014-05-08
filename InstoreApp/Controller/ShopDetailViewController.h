//
//  ShopDetailViewController.h
//  InstoreApp
//
//  Created by hanchao on 14-4-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *mtableView;
@property (nonatomic,assign) NSInteger shopId;

@end
