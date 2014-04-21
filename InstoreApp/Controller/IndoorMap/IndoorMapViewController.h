//
//  IndoorMapViewController.h
//  MBSMap
//
//  Created by sunyifei on 9/19/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSMapViewController.h"

@class StoreListView;
@interface IndoorMapViewController : UIViewController <MBSMapViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    int mSelectedFloorIndex;
    NSMutableArray *floorInforArray;
}

@property (nonatomic, retain) MBSMapViewController *mMapControl;
@property (nonatomic, retain) NSString *cityCodeUse;
@property (nonatomic, retain) NSString *firstFloorId;
@property (nonatomic, retain) UIButton *zoomInBtn;
@property (nonatomic, retain) UIButton *zoomOutBtn;
@property (nonatomic)         int mallId;

@property (nonatomic, retain) UITableView *mFloorSwitcher;
@property (nonatomic, retain) StoreListView *storeListView;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame withFloorId:(NSString *)strFloorId withMallId:(NSInteger)tempMallId withCityCode:(NSString *)cityCode withMallName:(NSString *)mallName;
@end
