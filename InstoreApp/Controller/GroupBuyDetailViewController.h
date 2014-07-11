//
//  GroupBuyDetailViewController.h
//  InstoreApp
//  团购详情
//  Created by evil on 14-6-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"
@class CouponModel;

@interface GroupBuyDetailViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *mtableView;
@property (nonatomic,retain) CouponModel *couponModel;

@property (retain, nonatomic) IBOutlet UIButton *btnFocus;
- (IBAction)btnFocusAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnGoNext;
- (IBAction)btnGoNextAction:(UIButton *)sender;


@end
