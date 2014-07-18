//
//  MyDownloadCoumonCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadCouponModel.h"
#import "EGOImageView.h"

@interface MyDownloadCoumonCell : UITableViewCell

@property (retain, nonatomic) DownloadCouponModel *couponModel;
@property (retain, nonatomic) IBOutlet EGOImageView *imageIcon;
@property (retain, nonatomic) IBOutlet UILabel *labTitle;
@property (retain, nonatomic) IBOutlet UILabel *labInstruction; //使用限制
@property (retain, nonatomic) IBOutlet UILabel *labDate;
@property (retain, nonatomic) IBOutlet UIImageView *imageGuoQi;

@property (retain, nonatomic) IBOutlet UILabel *labMianFei;


@end
