//
//  CouponDetailViewController.h
//  InstoreApp
//
//  Created by hanchao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *mtableView;

@end
