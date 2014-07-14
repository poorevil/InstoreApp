//
//  StoreDetail_detailCell.h
//  InstoreApp
//
//  Created by evil on 14-6-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoreDetail_RestaurantViewController;
@interface StoreDetail_detailCell : UITableViewCell
@property (nonatomic, retain) IBOutlet UILabel *detailLabel;
@property (nonatomic, retain) IBOutlet UIButton *slideUpBtn;
@property (nonatomic, assign) id<StoreDetail_RestaurantViewController> delegate;

-(IBAction)slideUpBtnAction:(id)sender;

@end
