//
//  MBSScrollView.h
//  MBSMap
//
//  Created by sunyifei on 9/21/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicDelegete.h"

@protocol MBSScrollTouchNotifyDelegate <NSObject>

-(void)touchStarted;
//zoomIn zoomOut
-(void)updateZoomInBtn:(BOOL)enabled;
-(void)updateZoomOutBtn:(BOOL)enabled;

@end

@interface MBSScrollView : UIScrollView <UIScrollViewDelegate, MapNavigationDelegate>

@property (nonatomic) BOOL hasZoomBtn;
@property (nonatomic) BOOL fViewInitialized;
@property (nonatomic, assign) id <MBSScrollGestureNotifyDelegate> gestureNotifyDelegate;
@property (nonatomic, assign) UIView *layoutView;
@property (nonatomic, retain) NSMutableArray *foreGroundViewList;
@property (nonatomic, assign) id <MBSScrollTouchNotifyDelegate> touchDelegate;

-(id)initWithFrame:(CGRect)frame;
-(void)createSubViews;
-(void)reloadMap;
-(void)removeOldMapViews;
-(void)removeForeGroundViews;
-(CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
-(void)reDrawSelectedIcons;
-(void)hightLightIconWithName:(NSString *)iconName;
-(void)removeHightLightIcons;
-(void)setCopyrightText:(int)type;
-(void)zoomin:(BOOL)zoomIn withParentCenter:(CGPoint)parentCenter;

-(CGRect)generateShareViewSizeforZoomLevel:(float)zoomLevel;
-(CGSize)getTotalViewSizeWithFrame:(CGRect)frameToCenter;
-(void)drawViewIntoContext:(CGContextRef)context forZoomLevel:(float)zoomLevel withFrame:(CGRect)frameToCenter;

-(void)restoreViewsWithZoomLevel:(float)zoomLevel;

@end


