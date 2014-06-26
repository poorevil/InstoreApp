//
//  MallNews_multiTableViewCell.h
//  InstoreApp
//
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EGOImageView;

@interface MallNews_multiTableViewCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;

@property (nonatomic, retain) IBOutlet EGOImageView *articleImageView_1;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel_1;
@property (nonatomic, retain) IBOutlet EGOImageView *articleImageView_2;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel_2;
@property (nonatomic, retain) IBOutlet EGOImageView *articleImageView_3;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel_3;

@property (nonatomic, retain) IBOutlet UIView *parentView;

@property (nonatomic, retain) NSDictionary *dict;
@end
