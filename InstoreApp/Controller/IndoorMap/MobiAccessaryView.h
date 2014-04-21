//
//  MobiDoubleLinesAccessaryView.h
//  SmartMall
//
//  Created by dujianping on 12/25/11.
//  Copyright (c) 2011 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MobiAccessaryView : UIView

@property (nonatomic, retain) UIImageView *firstLineImageView;
@property (nonatomic, retain) UILabel *firstLineTextLabel;

-(CGSize)getAccessaryViewSize;

@end
