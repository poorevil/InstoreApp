//
//  ForeGroundView.h
//  SmartMall
//
//  Created by sunyifei on 10/17/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapShape;
@interface ForeGroundView : UIView 
@property (nonatomic) CGFloat safeZoomLevel;

- (id)initWithFrame:(CGRect)frame andMapShape:(MapShape *)shape;
- (void)resize;
- (void)setNeedsDisplayForCurrentZoomLevel;
-(void)drawViewIntoContext:(CGContextRef)context forZoomLevel:(float)zoomLevel forFrame:(CGRect)frame;
@end
