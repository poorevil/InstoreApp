//
//  FocusStoreViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusStoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UIButton *btnIsRecommend;
- (IBAction)btnIsRecommendAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;


@end
