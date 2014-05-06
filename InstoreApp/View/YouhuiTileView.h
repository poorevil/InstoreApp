//
//  YouhuiTileView.h
//  InstoreApp
//
//  Created by han chao on 14-3-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSCollectionViewCell.h"
#import "EGOImageView.h"
@interface YouhuiTileView : PSCollectionViewCell
@property (retain, nonatomic) IBOutlet EGOImageView *picView;
@property (retain, nonatomic) IBOutlet EGOImageView *iconView;
@property (retain, nonatomic) IBOutlet UIView *viewGroup;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UIView *buttonGroup;

@property (retain, nonatomic) IBOutlet UIButton *commentCountLabel;
@property (retain, nonatomic) IBOutlet UIButton *collectCountLabel;


+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth;

@end
