//
//  MallNews_singleCell.h
//  InstoreApp
//
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;
@interface MallNews_singleCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *articleDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *summaryLabel;
@property (nonatomic, retain) IBOutlet EGOImageView *articleImageView;

@property (nonatomic, retain) IBOutlet UIView *parentView;

@property (nonatomic, retain) NSDictionary *dict;

-(void)setDict:(NSDictionary *)dict;

@end
