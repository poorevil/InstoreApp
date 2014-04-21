//
//  SVGFloor.h
//  SeismicXML
//
//  Created by sunyifei on 9/5/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ParseOperation.h"
#import "MBSMapViewController.h"

enum {
    kInitSpace = 0,
    kInitFloor = 1
}   NextInitObject;

@class MBSFloor, NSXMLConnectedParser;
@interface MBSMall : NSObject <ParseOperationDelegate>

@property (nonatomic, assign) MBSMapViewController *mapContainer;
@property (nonatomic, retain) NSMutableDictionary *floorDict;
@property (nonatomic, retain) NSString *currentFloorId;
@property (nonatomic, retain) NSString *firstFloorId;
@property (nonatomic) long long willSelectStoreId;
@property (nonatomic) BOOL currentMallInitSuccess;
@property (nonatomic, assign) id <MBSMapViewControllerDelegate> delegate;

+ (MBSMall *)getCurrentMall;
- (void)initFirstFloorMap;

- (void)tryInitMapWithFloorId:(NSString *)floorId;
- (void)initMapWithFloorId;
- (void)initMapWithFloorIdNum:(int)floorIdNum andStoreId:(long long)storeId;
- (void)addFloorInfo:(NSDictionary *)attributeDict;
- (void)tryInitCurrentMallFromServer;

- (NSInteger)spaceId;
- (void)setSpaceId:(int)id;
- (NSString *)spaceName;
- (void)setSpaceName:(NSString *)spaceName;

- (NSArray *)getFloorArrayInNegativeSequence:(BOOL)negativeSequence;

- (void)finishParsingFloor:(NSString *) floorId;
- (void)downloadFloorMapFinished;
- (void)downloadFloorMapFailed;
@end
