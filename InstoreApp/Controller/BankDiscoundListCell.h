//
//  BankDiscoundListCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface BankDiscoundListCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIView *parentView;
@property (retain, nonatomic) IBOutlet UILabel *labTitle;
@property (retain, nonatomic) IBOutlet EGOImageView *imgBankLogo;
@property (retain, nonatomic) IBOutlet UILabel *labStartTime;
@property (retain, nonatomic) IBOutlet UILabel *labEndTime;
@property (retain, nonatomic) IBOutlet EGOImageView *imgView;
@property (retain, nonatomic) IBOutlet EGOImageView *imageStoreLogo;

@end
