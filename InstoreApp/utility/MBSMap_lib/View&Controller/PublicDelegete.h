//
//  PublicDelegete.h
//  SmartMall
//
//  Created by sunyifei on 11/10/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//


@protocol MBSScrollGestureNotifyDelegate <NSObject>
- (void)setContentOffset:(CGPoint)contentOffset;
- (void)setContentSize:(CGSize)contentSize withOffset:(CGPoint)contentOffset;
@end


@protocol MapNavigationDelegate <NSObject>
-(void)navigateToRect:(CGRect)rect;
@end