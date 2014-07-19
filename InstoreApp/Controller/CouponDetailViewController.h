//
//  CouponDetailViewController.h
//  InstoreApp
//  优惠劵详情页
//  Created by hanchao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CouponModel;

@interface CouponDetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *mtableView;
@property (nonatomic,retain) CouponModel *couponModel;

- (IBAction)btnFocusAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnFocus;
- (IBAction)btnGoNextAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnGoNext;

@end
