//
//  DownloadCouponDetailViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-19.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"
#import "DownloadCouponModel.h"

@interface DownloadCouponDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (assign, nonatomic) NSInteger cid;
//@property (retain, nonatomic) CouponModel *couponModel;

@property (retain, nonatomic) DownloadCouponModel *downloadCouponModel;



@end
