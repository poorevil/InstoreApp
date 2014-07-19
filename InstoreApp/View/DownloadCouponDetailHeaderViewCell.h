//
//  DownloadCouponDetailHeaderViewCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-19.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "DownloadCouponModel.h"

@interface DownloadCouponDetailHeaderViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet EGOImageView *imageIcon;
@property (retain, nonatomic) IBOutlet UILabel *labTitle;
@property (retain, nonatomic) IBOutlet UILabel *labFree;
@property (retain, nonatomic) IBOutlet UILabel *labInstruction;

@property (retain, nonatomic) IBOutlet EGOImageView *imageCode;
@property (retain, nonatomic) IBOutlet UILabel *labCode;

@property (retain, nonatomic) DownloadCouponModel *downloadCouponModel;

@end
