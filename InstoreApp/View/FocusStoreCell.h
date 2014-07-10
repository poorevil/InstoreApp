//
//  FocusStoreCell.h
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusStoreModel.h"
#import "FocusStoreView.h"
#import "FocusStoreInterface.h"

@protocol UpDateFocusStoreCountDelegate <NSObject>

-(void)upDataFocusStoreCount:(BOOL)isAddOrDelete; //真为添加，假为减少

@end

@interface FocusStoreCell : UITableViewCell<FocusStoreViewTapDelegate>

@property (retain, nonatomic) FocusStoreModel *view1;
@property (retain, nonatomic) FocusStoreModel *view2;
@property (retain, nonatomic) FocusStoreModel *view3;
@property (retain, nonatomic) FocusStoreModel *view4;

@property (retain, nonatomic) FocusStoreInterface *focusStoreInterface;

@property (assign, nonatomic) id<UpDateFocusStoreCountDelegate>delegate;

@end
