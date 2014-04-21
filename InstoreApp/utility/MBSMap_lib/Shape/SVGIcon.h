//
//  SVGIcon.h
//  MBSMap
//
//  Created by sunyifei on 9/15/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SVGShape;

@interface SVGIcon : NSObject {
    
}
@property (nonatomic) int     seq;
@property (nonatomic) CGPoint centerPoint; //在zoomLevel为1时的中心点
@property (nonatomic) CGSize  baseSize;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *brief;  //在选中icon时显示的关于icon的描述
@property (nonatomic, retain) NSMutableArray *mapShapeList;


- (void)addPathObject:(SVGShape *)pathObject;
- (void)drawPath:(CGContextRef)context isHighLighted:(BOOL)isHighLighted;
- (void)drawStrokePath:(CGContextRef)context;
- (void)regenerateDefaultPathsWithZoomLevel:(CGFloat)theZoomLevel;
- (void)regenerateDefaultPathsWithZoomLevel:(CGFloat)theZoomLevel withBasePoint:(CGPoint)basePoint;
- (CGPoint)getBasePoint;
@end
