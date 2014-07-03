//
//  BankCardCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface BankCardCell : UITableViewCell
@property (retain, nonatomic) IBOutlet EGOImageView *bankImageIcon;
@property (retain, nonatomic) IBOutlet UILabel *labBankName;
@property (retain, nonatomic) IBOutlet UILabel *labDiscountCount;
@property (retain, nonatomic) IBOutlet UILabel *labSlogan;
@property (retain, nonatomic) IBOutlet UIImageView *imgGoNext;

@end
