//
//  MyVIPCardViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyVIPCardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UIImage *VIPCardNumberImage;
@property (retain, nonatomic) NSArray *list;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@end
