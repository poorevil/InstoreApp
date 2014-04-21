//
//  IntMBSPopup.h
//  MBSMapViewController
//
//  Created by sunyifei on 3/29/13.
//
//

#import <Foundation/Foundation.h>
#import "MBSPopup.h"

@interface MBSPopup (Internal)


#pragma mark - adjust popup position
- (void)updateCenterWithFrame:(CGRect)frameRect andZoomLevel:(float)zoomLevel;
- (void)updateCenterWithFrame:(CGRect)frameRect andZoomScale:(float)tempZoomScale;


- (void)updateForeGroundViewInScrollView:(MBSScrollView *)scrollView;
- (UIView*)getLeftAccessoryView;


- (void)resetPopUp;
- (void)popUpForStoreId:(long long)storeId intoView:(MBSScrollView *)view;
- (void)popUpViewAtPoint:(CGPoint *)point intoView:(UIScrollView *)view;
- (void)removePopUpFromScrollView:(UIView *)view;
@end
