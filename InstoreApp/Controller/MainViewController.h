//
//  MainViewController.h
//  InstoreApp
//
//  Created by han chao on 14-3-17.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MainViewController : BaseViewController < UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) IBOutlet UITableView *mtableView;

@end
