//
//  MapShape.h
//  MBSMap
//
//  Created by sunyifei on 9/15/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVGShape.h"

enum FONT_LEVEL {
    FONT_BIG = 0,
    FONT_MIDDLE = 2,
    FONT_SMALL = 3,
};

@interface MapShape : SVGShape
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *rNo;
@property (nonatomic) BOOL isFake;
@property (nonatomic) BOOL fBoldFont;
@property (nonatomic) enum FONT_LEVEL  fontLevel;
@property (nonatomic) CGPoint theCenterPoint;
@property (nonatomic) float nameFontSize;
@property (nonatomic) CGRect nameRect;

- (CGPoint)getCurrentCenterPoint;
- (void)regenerateDefaultPathsWithZoomLevel:(CGFloat)zoomLevelUsed;


- (void)drawName:(CGContextRef)context withNameFontSize:(CGFloat)theFontSize inNameRect:(CGRect)theNameRect useSmallFont:(BOOL)fUseSmallFont;
- (void)fillPathWithOutName:(CGContextRef)context;
- (void)drawZeroAngleRect:(CGContextRef)context withZoomLevel:(float)zoomLevel;
- (void)cgFillRect:(CGRect)rect intoContext:(CGContextRef)context;
- (void)cgDrawRedRect:(CGRect)rect intoContext:(CGContextRef)context;

@end

@interface  STRShape: MapShape
@property (nonatomic) BOOL mfNameHasChineseOrBlank;

- (void)generateNameRectAndFontSizeWithZoomLevel:(float)theZoomLevel intoFontSize:(float *)theFontSize intoCGRect:(CGRect *)theNameRect withMaxFontSize:(float)maxFont;
@end

@interface  IconShape: MapShape
@property (nonatomic, retain) NSString *iconName;
@property (nonatomic) int displayLevel;

- (void)drawIcon:(CGContextRef)context iconRect:(CGRect)targetRect withZoomLevel:(CGFloat)zoomLevel isHighLighted:(BOOL)isHighLighted;
- (void)drawIcon:(CGContextRef)context isHighLighted:(BOOL)isHighLighted;
@end

@interface ASICIItxtShape : MapShape

- (void)generateNameRectAndFontSizeWithZoomLevel:(float)theZoomLevel intoFontSize:(float *)theFontSize intoCGRect:(CGRect *)theNameRect;

- (void)drawRoundEdgeIntoContext:(CGContextRef)context withRadius:(float)radius forZoomLevel:(float)zoomLevel;
@end


@interface GateShape : STRShape
@property (nonatomic) BOOL fVisible;
@property (nonatomic) CGRect pathRect;

- (void)generateGateRectForZoomLevel:(float)theZoomLevel andFontSize:(float)fontSize;
@end
