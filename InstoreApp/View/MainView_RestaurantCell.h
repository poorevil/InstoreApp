//
//  MainView_ RestaurantCell.h
//  InstoreApp
//
//  Created by evil on 14-6-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView_BaseCell.h"
#import "EGOImageView.h"

@interface MainView_RestaurantCell : MainView_BaseCell

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) NSArray *dataList;

@property (nonatomic, retain) IBOutlet EGOImageView *imageView_1;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel_1;
@property (nonatomic, retain) IBOutlet EGOImageView *imageView_2;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel_2;
@property (nonatomic, retain) IBOutlet EGOImageView *imageView_3;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel_3;

-(IBAction)moreBtnAction:(id)sender;

@end
