//
//  ShopViewController.h
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ShopViewController : BaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) IBOutlet UITableView *mtable;

@property (nonatomic,strong) IBOutlet UIButton *floorBtn;
@property (nonatomic,strong) IBOutlet UIButton *cateBtn;
@property (nonatomic,strong) IBOutlet UIButton *sortBtn;

@property (nonatomic,strong) IBOutlet UIButton *likeBtn;

@property (nonatomic,assign) BOOL isShowLikeOnly;


- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
