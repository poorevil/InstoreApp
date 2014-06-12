//
//  CouponViewController.h
//  InstoreApp
//  优惠列表页
//  Created by hanchao on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITableView *mtableView;
@property (nonatomic, retain) IBOutlet UIButton *cateBtn;
@property (nonatomic, retain) IBOutlet UIButton *typeBtn;
@property (nonatomic, retain) IBOutlet UIButton *orderBtn;

@property (nonatomic, retain) IBOutlet UIButton *favorBtn;

@end
