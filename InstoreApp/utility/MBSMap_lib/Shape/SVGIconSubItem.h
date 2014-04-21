//
//  IconShape.h
//  MBSMapViewController
//
//  Created by sunyifei on 6/12/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import "SVGShape.h"

@interface SVGIconSubItem : SVGShape
@property (nonatomic, retain) NSString *fillColor;

- (void)drawPath:(CGContextRef)context withDrawMode:(int)drawMode isHightLighted:(BOOL)isHightLighted;
- (void)addStrokePathOnly:(CGContextRef)context;

@end
