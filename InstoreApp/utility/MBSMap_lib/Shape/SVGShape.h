//
//  SVGShape.h
//  MBSMap
//
//  Created by sunyifei on 7/28/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (* funActionString)(NSString *, CGContextRef);

typedef struct _functionString{
    unsigned int style;
    NSString *functionStr;
    void (*funActionString) (NSString *, CGContextRef);
} FunStr;

//Enum of actions

typedef struct _actionInfo{
    unsigned int startNumber;
    unsigned int action;
}STRUCT_ACTION;

enum MAPSHAPE_TYPE  {
    SHAPE_UNKNOWN  = 0,
    SHAPE_BG       = 1,
    SHAPE_SQUE     = 2,
    SHAPE_EMPTY    = 3,
    SHAPE_DSBLD    = 4,
    SHAPE_STR      = 5,
    SHAPE_LG       = 6,
    SHAPE_PICON    = 7,
    SHAPE_DLINE    = 8,
    SHAPE_GATE     = 9
};

funActionString initFillRuleintoContext(NSString *fillRule, CGContextRef context);
funActionString initFillintoContext(NSString *fill, CGContextRef context);
funActionString initStrokeintoContext(NSString *stroke, CGContextRef context);
funActionString initStrokeWidthintoContext(NSString *strokeWidth, CGContextRef context);

@interface SVGShape : NSObject
@property (nonatomic) long long  objId;
@property (nonatomic) CGMutablePathRef pathsUsed;
@property (nonatomic) enum MAPSHAPE_TYPE eType;

@property (nonatomic) int pathDrawMode;
@property (nonatomic) CGRect rect;
@property (nonatomic) CGFloat rectAngle;
@property (nonatomic) CGPoint basePoint;
@property (nonatomic) CGRect maxRect;

+ (BOOL)isIconStrokeColor:(NSString *)strColor;
- (BOOL)initStreaks:(NSDictionary *)attributeDict;
- (BOOL)collectInfo:(NSDictionary *)attributeDict;
- (BOOL)getRectInfo:(NSDictionary *)attributeDict;
- (void)getMaxRectFromString:(NSString *)strMaxRect;
- (void)regenerateDefaultPathsWithZoomLevel:(CGFloat)theZoomLevel;
- (void)regeneratePathsWithZoomLevel:(CGFloat)theZoomLevel inToPaths:(CGMutablePathRef)paths;
- (void)drawPath:(CGContextRef)context withDrawMode:(int)drawMode;

@end
