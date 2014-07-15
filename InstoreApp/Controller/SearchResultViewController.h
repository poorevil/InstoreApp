//
//  SearchResultViewController.h
//  InstoreApp
//  查询结果
//  Created by evil on 14-5-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
//#import "PSCollectionView.h"
//#import "PullPsCollectionView.h"

@interface SearchResultViewController : BaseViewController </*PSCollectionViewDelegate,PSCollectionViewDataSource,UIScrollViewDelegate,PullPsCollectionViewDelegate*/UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *myTableView;
//@property (nonatomic,retain) PullPsCollectionView *collectionView;
@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,strong) NSString *searchKeyWord;

@end
