//
//  IndoorMapViewController2.h
//  MBSMapSample
//
//  Created by sunyifei on 4/1/13.
//
//

#import "IndoorMapViewController.h"
#import "MBSPopupDelegate.h"

@class MBSMapViewController;
@interface IndoorMapWithLeftPopBtnViewController : IndoorMapViewController <MBSPopupDelegate>
@property (strong, nonatomic) MBSMapViewController *mMap;

- (void)selectStoreWithFloorId:(int)floorId storeId:(long long)storeId;

@end
