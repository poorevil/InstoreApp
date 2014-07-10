//
//  StoreList_headerView.h
//  InstoreApp
//
//  Created by evil on 14-6-24.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreList_headerView : UIView

@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentControl;

@property (nonatomic, retain) IBOutlet UIView *filterParentView;
@property (nonatomic, retain) IBOutlet UIButton *floorBtn;
@property (nonatomic, retain) IBOutlet UIButton *categoryBtn;
@property (nonatomic, retain) IBOutlet UIButton *orderBtn;
@property (nonatomic, retain) IBOutlet UIButton *favorBtn;

@property (nonatomic, retain) IBOutlet UIImageView *line;

-(void)hideFilterView:(BOOL)state;
@end
