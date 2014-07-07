//
//  MallNewsDetailViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponDetailInterface.h"
#import "CouponModel.h"
#import "StoreModel.h"

@interface MallNewsDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) NSInteger youhuiID;

@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UIView *bottomView;

@property (retain, nonatomic) CouponModel *couponModel;
@property (retain, nonatomic) CouponDetailInterface *couponDetailInterface;

- (IBAction)btnGoNextAction:(UIButton *)sender;

@end
