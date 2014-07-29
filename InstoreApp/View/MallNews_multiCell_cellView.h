//
//  MallNews_multiCell_cellView.h
//  InstoreApp
//
//  Created by Mac on 14-7-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface MallNews_multiCell_cellView : UIView

@property (nonatomic, retain) IBOutlet EGOImageView *articleImageView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

@property (nonatomic, retain) NSString *url;

@end
