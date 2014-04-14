//
//  YouhuiTileView.h
//  InstoreApp
//
//  Created by han chao on 14-3-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionViewCell.h"

@interface YouhuiTileView : PSCollectionViewCell
@property (retain, nonatomic) IBOutlet UIImageView *picView;
@property (retain, nonatomic) IBOutlet UIImageView *iconView;
@property (retain, nonatomic) IBOutlet UIView *viewGroup;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIView *buttonGroup;

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth;

@end
