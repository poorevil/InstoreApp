//
//  MBSFloor.h
//  MBSMap
//
//  Created by sunyifei on 9/19/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseOperation.h"
#import "MobiConnection.h"

@interface MBSFloorBase : NSObject {
    
}
@property (nonatomic, retain) NSString *floorID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *brief;
@end

@interface MBSFloorURL : MBSFloorBase {
    
}
@property (nonatomic, retain) NSMutableArray *iconUrls;

@end

@interface MBSFloor : MBSFloorBase <ParseOperationDelegate> {
    BOOL needParse;
    NSInteger spaceId;
}
@property (nonatomic, retain) MobiConnection *conn;
@property (nonatomic, assign) NSOperationQueue *queue;
@property (nonatomic) CGPoint size;
@property (nonatomic) CGPoint zoomLevelBoundary;
@property (nonatomic) CGFloat defaultZoomLevel;
@property (nonatomic) float northArrowRotation; //指北针的旋转弧度

- (id)init;
- (void)initCurrentFloorFromServerWithSpaceId:(NSInteger)spaceId;
- (void)downLoadCurrentFloorMapWithSpaceid:(NSInteger)spaceId;

@end
