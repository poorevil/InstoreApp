//
//  BankDiscoundListViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"

@interface BankDiscoundListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (assign, nonatomic) NSInteger bankId;
//@property (retain, nonatomic) NSString *titleString;

@end
