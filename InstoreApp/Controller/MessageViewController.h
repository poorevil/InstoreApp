//
//  MessageViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@end
