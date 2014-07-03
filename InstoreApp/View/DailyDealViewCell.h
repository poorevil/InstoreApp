//
//  DailyDealViewCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-1.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface DailyDealViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *shortTitle;
@property (retain, nonatomic) IBOutlet EGOImageView *imgView;
@property (retain, nonatomic) IBOutlet UILabel *summary;
@property (retain, nonatomic) IBOutlet UILabel *focusCount;


@end
