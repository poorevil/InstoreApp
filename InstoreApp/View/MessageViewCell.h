//
//  MessageViewCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *labTitle;
@property (retain, nonatomic) IBOutlet UILabel *labDate;
@property (retain, nonatomic) IBOutlet UILabel *labDescription;

@end
