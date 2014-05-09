//
//  DownloadCouponsViewController.h
//  InstoreApp
//  我的优惠
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PSCollectionView.h"
#import "PullPsCollectionView.h"

@interface DownloadCouponsViewController : BaseViewController<PSCollectionViewDelegate,PSCollectionViewDataSource,
UIScrollViewDelegate,PullPsCollectionViewDelegate>

@property(nonatomic,retain) PullPsCollectionView *collectionView;
@property(nonatomic,retain)NSMutableArray *items;

//@property (nonatomic,strong) IBOutlet UIView *optionView;//筛选view
//@property (nonatomic,strong) IBOutlet UISegmentedControl *segmentedControl;

//@property (nonatomic,strong) IBOutlet UIButton *categoryBtn;//分类
//@property (nonatomic,strong) IBOutlet UIButton *orderBtn;//排序

//@property (nonatomic,strong) IBOutlet UIView *viewParent;//瀑布流view


@end
