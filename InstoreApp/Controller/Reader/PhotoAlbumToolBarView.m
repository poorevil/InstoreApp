//
//  PhotoAlbumToolBarView.m
//  ImageViewer
//
//  Created by hanchao on 13-8-21.
//  Copyright (c) 2013年 hanchao. All rights reserved.
//

#import "PhotoAlbumToolBarView.h"

@implementation PhotoAlbumToolBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc
{
//    self.leftBtn = nil;
    self.rightBtn = nil;
//    self.centerBtn = nil;
    
    self.indexLabel = nil;
    
    [super dealloc];
}

@end
