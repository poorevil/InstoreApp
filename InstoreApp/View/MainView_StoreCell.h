//
//  MainView_ StoreCell.h
//  InstoreApp
//  品牌推荐
//  Created by evil on 14-6-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView_StoreCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIView *parentView;

@property (nonatomic, retain) NSArray *dataList;


-(IBAction)moreBtnAction:(id)sender;
@end
