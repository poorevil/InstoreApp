//
//  MapNavigationView.h
//  SmartMall
//
//  Created by sunyifei on 11/9/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicDelegete.h"


@interface MapNavigationView : UIView  <MBSScrollGestureNotifyDelegate> 

@property (nonatomic, retain) UIView *screenBoundIndicator;
@property (nonatomic, assign) id <MapNavigationDelegate> navigationDelegate;
//@property (nonatomic, retain) UILabel *zoomLeveLLabel;

- (id)initWithFrame:(CGRect)frame andScrollViewSize:(CGSize)scrollSize andRealMapSize:(CGSize)realMapSize;
- (void)resetWithScrollViewSize:(CGSize)scrollSize andRealMapSize:(CGSize)realMapSize;
- (void)generatePaths;
@end


