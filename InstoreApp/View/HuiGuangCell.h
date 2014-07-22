//
//  HuiGuangCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "RTLabel.h"
#import "HuiGuangModel.h"

@interface HuiGuangCell : UITableViewCell
@property (retain, nonatomic) IBOutlet EGOImageView *imageIcon;
@property (retain, nonatomic) IBOutlet EGOImageView *Image;
@property (retain, nonatomic) IBOutlet UILabel *labTitle;
@property (retain, nonatomic) IBOutlet UIButton *btnAllComment;
- (IBAction)btnAllCommentAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIView *commentView;
@property (retain, nonatomic) IBOutlet UIView *parentView;
@property (retain, nonatomic) IBOutlet UIImageView *imageStoreOrSaler;

@property (retain, nonatomic) RTLabel *labComment;
@property (retain, nonatomic) HuiGuangModel *huiGuangModel;

@end
