//
//  DailyDealViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-1.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"
#import "DailyDealInterface.h"
#import "EGORefreshTableHeaderView.h"

@interface DailyDealViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>

@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (retain, nonatomic) DailyDealInterface *dailyDealInterface;
@property (nonatomic, retain) NSMutableArray *itemList;
@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, assign) NSInteger currentPage;
@property (assign, nonatomic) NSInteger everyPageCount;

@property (nonatomic,retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic,assign) BOOL reloading;

@end
