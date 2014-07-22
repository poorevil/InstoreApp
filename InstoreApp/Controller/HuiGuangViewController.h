//
//  HuiGuangViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"

@interface HuiGuangViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UILabel *labPosition;
- (IBAction)btnMapAction:(UIButton *)sender;

@property (retain, nonatomic) NSArray *itemList;

@end
