//
//  MBSMapViewController.h
//  MBSMap
//
//  Created by sunyifei on 9/4/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBSScrollView.h"
#import "BaseDataType.h"

@class StoreInfo;
@protocol MBSMapViewControllerDelegate <NSObject>

//floorSwitcher
@required
-(void)createFloorSwitchControl:(UIView *)mapView; //创建楼层切换控件
-(void)onFloorSelected:(NSString *)strFloor;       //在地图控件内部切换楼层后通知楼层控件更新楼层
-(void)hideFloorSwitcherIfNeeded;                  //如果在用户操作地图时需要隐藏楼层切换控件，则在此函数内实现控件的隐藏

//showProgressMessages
@optional
-(void)willLoadMapData;
-(void)didLoadMapDataSuccessfully;
-(void)didLoadMapDataFailed;
-(void)updateDownloadPercentage:(int)percentage;
-(void)setColors;

//zoomIn zoomOut
-(void)updateZoomInBtn:(BOOL)enabled;
-(void)updateZoomOutBtn:(BOOL)enabled;

//detailView
- (void)switchToStoreDetailViewWithStoreInfo:(BaseStoreInfo*)baseStoreInfo;

//shareMap
//-(void)shareMapWithStoreInfo:(StoreInfo *)storeInfo;
-(void)createPopupShareIntroductionView:(CGPoint)offSet;

@end

@class  MBSScrollView, MapNavigationView;
@interface MBSMapViewController : UIViewController <MBSScrollTouchNotifyDelegate > //UIScrollViewDelegate,

@property (nonatomic) int mapInstanceTag;
@property (nonatomic, assign) BOOL isShowingFacilityView;
@property (nonatomic) BOOL hasZoomBtn;

- (id)initWithFrame:(CGRect)rect withMallId:(int)mallId withDelegate:(id<MBSMapViewControllerDelegate>)delegateUse;
- (void)setUseCopyrightText1;
- (void)tryInitMall;
- (void)generateMap;

- (void)setEnableStoreDetailButton:(BOOL)enable;
- (BOOL)storeDetailButtonEnabled;

- (void)loadDataFail;
- (void)selectStoreWithFloorId:(int)floorId storeId:(long long)storeId;
- (void)updateDownloadPercentage:(int)percentage;
- (void)setDelegate:(id<MBSMapViewControllerDelegate>)delegateUse;

- (UIImage *)createMapImage;

- (void)showFacilityFilterView;
- (void)hideFacilityFilterView:(id)sender;

- (void)zoomInMap;
- (void)zoomOutMap;
- (void)switchFloor:(NSString *)floorId;

@end
