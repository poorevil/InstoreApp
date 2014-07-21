//
//  CouponViewController.h
//  InstoreApp
//  优惠列表页
//  Created by hanchao on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CategoryModel.h"
#import "EGORefreshTableHeaderView.h"

@interface CouponViewController : BaseViewController<EGORefreshTableHeaderDelegate>

@property (nonatomic, retain) IBOutlet UITableView *mtableView;
//@property (nonatomic, retain) IBOutlet UIButton *cateBtn;
@property (nonatomic, retain) IBOutlet UIButton *typeBtn;
@property (nonatomic, retain) IBOutlet UIButton *orderBtn;

@property (assign, nonatomic) BOOL isOrder;
@property (assign, nonatomic) BOOL isOrder1;
@property (assign, nonatomic) BOOL isOrder2;
@property (assign, nonatomic) NSInteger cid;
@property (assign, nonatomic) NSInteger type;  //  优惠类型  <1, '优惠活动'>, <2, '优惠券'>, <3, '团购'>
//@property (retain, nonatomic) NSString *cidName;
@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件

@property (nonatomic, retain) IBOutlet UIButton *favorBtn;
- (IBAction)btnOrderAction:(UIButton *)sender;
- (IBAction)btnCategoryAction:(UIButton *)sender;
- (IBAction)btnMyFocusYouHuiAction:(UIButton *)sender;

@property (nonatomic,retain) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic,assign) BOOL reloading;

-(void)loadCategoryData;
-(void)loadTypeData:(NSInteger)type;

@end
