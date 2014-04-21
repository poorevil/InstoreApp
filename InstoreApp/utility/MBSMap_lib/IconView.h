//
//  IconView.h
//  MBSMapViewController
//
//  Created by dujianping on 5/1/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVGIcon.h"

@class MapShape;
@interface IconView : UIView

@property (nonatomic) BOOL isHighLighted;
@property (nonatomic, assign) CGFloat defaultZoomLevel;
@property (nonatomic, retain) SVGIcon *icon;

@end
