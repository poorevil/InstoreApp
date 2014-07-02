//
//  DailyDealViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-1.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"

@interface DailyDealViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, retain) NSMutableArray *itemList;

@end
