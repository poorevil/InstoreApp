//
//  DownloadCouponSuccessViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-21.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "CouponDownloadModel.h"

@interface DownloadCouponSuccessViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIView *imageIconSubview;
@property (retain, nonatomic) IBOutlet EGOImageView *imageIcon;
@property (retain, nonatomic) IBOutlet UILabel *labTitle;
@property (retain, nonatomic) IBOutlet UILabel *labDate;
@property (retain, nonatomic) IBOutlet UILabel *labNum;
@property (retain, nonatomic) IBOutlet UILabel *labInstruction;

@property (retain, nonatomic) NSString *titleStr;
@property (retain, nonatomic) NSString *imageURL;
@property (retain, nonatomic) CouponDownloadModel *couponDownloadModel;
@property (retain, nonatomic) IBOutlet UIButton *btnViewCoupon;

@end
