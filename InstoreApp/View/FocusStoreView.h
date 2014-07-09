//
//  FocusStoreView.h
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface FocusStoreView : UIView
@property (retain, nonatomic) IBOutlet EGOImageView *storeIogo;
@property (retain, nonatomic) IBOutlet UIImageView *isFocusImage;
@property (retain, nonatomic) IBOutlet UILabel *labStoreName;

@end
