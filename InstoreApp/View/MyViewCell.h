//
//  MyViewCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *labTitle;
@property (retain, nonatomic) IBOutlet UILabel *labCount;

@property (retain, nonatomic) NSDictionary *textDict;

@end
