//
//  ShopViewController.h
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ShopViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) IBOutlet UITableView *mtable;

@end
