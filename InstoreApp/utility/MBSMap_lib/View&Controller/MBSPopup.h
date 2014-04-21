//
//  MBSPopup.h
//  SeismicXML
//
//  Created by sunyifei on 8/17/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBSPopupItem.h"
#import "MBSPopupDelegate.h"

@class MBSPopUpContainer, MBSScrollView;
@interface MBSPopup : NSObject

//选中某图形后改变，一般为选中的店铺或图标的名称
@property (nonatomic, retain) NSString *popUpTitle;

//选中某图形后改变，一般为选中店铺的房间号
@property (nonatomic, retain) NSString *popUpDetail;

//标识是否弹出气球当前可见
@property (nonatomic) BOOL show;

//是否显示弹出气球
@property (nonatomic) BOOL canShowPopup;

//弹出气球中是否有LeftAccessoryView
@property (nonatomic) BOOL fHasLeftAccessoryView;

//地图上点击后弹出的气球界面，可定制
@property (nonatomic, retain) id <MBSPopupItem> popUpView;
@property (nonatomic, assign) id <MBSPopupDelegate> delegate;


+ (MBSPopup *)getInstance;
- (void)popUpAlertForNewStore;

@end
