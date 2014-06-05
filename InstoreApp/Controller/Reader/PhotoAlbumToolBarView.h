//
//  PhotoAlbumToolBarView.h
//  ImageViewer
//
//  Created by hanchao on 13-8-21.
//  Copyright (c) 2013年 hanchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumToolBarView : UIView

@property (nonatomic,retain) IBOutlet UIButton *leftBtn;
@property (nonatomic,retain) IBOutlet UIButton *rightBtn;
@property (nonatomic,retain) IBOutlet UIButton *centerBtn;

@property (nonatomic,retain) IBOutlet UILabel *indexLabel;

@end
