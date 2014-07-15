//
//  StoreListFocusedViewController.h
//  InstoreApp
//  已关注的商家
//  Created by evil on 14-7-14.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"

@interface StoreListFocusedViewController : BaseViewController <UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *mtableView;

@end
