//
//  mapManager.h
//  mapManager
//
//  Created by sunyifei on 7/28/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapShape.h"

extern float kfMinFontSize;
extern float kCopyRightHeight;

@class MapShape, MBSFloor;
@interface MapManager : NSObject 

@property (nonatomic) int mallType;
@property (nonatomic) BOOL isDrawing; //避免Drawmap过程中被release

@property (nonatomic) float minStrokeWidth;
@property (nonatomic) float maxStrokeWidth;
@property (nonatomic) float iconStretchLevel;
@property (nonatomic) float defaultZoomLevel;
@property (nonatomic) BOOL storeDetailButtonEnabled;
@property (nonatomic) BOOL enableMapCorrect;
@property (nonatomic) BOOL needReset;
@property (nonatomic) BOOL willSelectStore;
@property (nonatomic) long long willSelectStoreId;

@property (nonatomic, retain) NSMutableArray *storeList;
@property (nonatomic, retain) NSMutableArray *selectedShapeList;
@property (nonatomic, retain) NSMutableArray *emptyShapeList;
@property (nonatomic, retain) NSMutableArray *unUsedStoreList;
@property (nonatomic, retain) NSMutableArray *iconList;
@property (nonatomic, retain) NSMutableArray *highLightIconList;
@property (nonatomic, retain) NSMutableArray *bkShapeList;
@property (nonatomic, retain) NSMutableArray *txtShapeList;
@property (nonatomic, retain) NSMutableArray *gateList;
@property (nonatomic, retain) NSMutableArray *squareList;
@property (nonatomic, retain) NSMutableArray *dLineShapeList;
@property (nonatomic, retain) NSMutableArray *lGList;

@property (nonatomic, retain) NSMutableArray *cIIList;
@property (nonatomic, retain) NSMutableArray *cheInTxtList;
@property (nonatomic, retain) NSMutableArray *entList;

@property (nonatomic, retain) MapShape *currentShape;
@property (nonatomic) float mapWidth;
@property (nonatomic) float mapHeight;
@property (nonatomic) int mapInstanceTag;
@property (nonatomic) CGPoint cPoint;
@property (nonatomic) float gateFontSize;

@property (nonatomic) CGRect selectedRect;

+ (MapManager *)getInstance;
- (void)resetStrokeWidth;
- (void)reset;
- (void)updateInstanceCount;
- (void)generateMapPaths;

- (void)drawMapIntoContext:(CGContextRef)context inRect:(CGRect)viewRect;

- (void)initFillColor:(NSString*)strFillColor inToContext:(CGContextRef)contextMap;
- (void)initStrokeColor:(NSString*)strStrokeColor inToContext:(CGContextRef)contextMap;

- (float)zoomMin;
- (float)zoomMax;

- (void)updateZoomBoundaryFoorInfo:(MBSFloor*)floorInfo;
- (BOOL)needStretchOnFirstInit;

- (BOOL)needShowNavigationView;

- (float)getFontSizeForZoomLevel:(float)tempZoomLevel withFontLevel:(enum FONT_LEVEL)fontLevel;
- (float)getStrokeWidth;
- (float)drawMapX2Screen:(float)mapX withZoomLevel:(CGFloat) theZoomLevel;
- (float)drawMapY2Screen:(float)mapY withZoomLevel:(CGFloat) theZoomLevel;
- (CGRect)drawMapRect2Screen:(CGRect)rect withZoomLevel:(CGFloat) theZoomLevel;

- (float)zoom:(float)fValue;
- (float)getIconZoomLevel;

- (float)getShowAllZoomLevel;
- (float)getShowMostZoomLevel;
- (float)getShowMinZoomLevel;

- (float)getActualZoomLevel;
- (CGPoint)viewPoint2MapPoint:(CGPoint)viewPoint;

- (BOOL)selectMapShapeWithStoreId:(long long)storeId andTouchPoint:(CGPoint*)touchPoint;
- (NSString *)getPopupInfoIfTouched:(CGPoint *)touchPoint;
- (void)updateIconListWithSelectedIconName:(NSString *)iconName;
- (void)updateIconListWithNothingSelect;
- (NSString *)getIconNameIfTouched:(CGPoint *)touchPoint;
- (void)udpateFlagsWithoutSelect;
- (void)tryReset;

@end
