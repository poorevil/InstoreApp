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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//-(void)awakeFromNib
//{
//    UIImage *imgbg = [UIImage imageNamed:@"btnBackground"];
//    
////    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
////        imgbg = [imgbg stretchableImageWithLeftCapWidth:5 topCapHeight:5];
////    }else{
//        imgbg = [imgbg stretchableImageWithLeftCapWidth:5 topCapHeight:5];
////    }
//    
//    
//    [self.leftBtn setBackgroundImage:imgbg forState:UIControlStateNormal];
//    [self.rightBtn setBackgroundImage:imgbg forState:UIControlStateNormal];
//    [self.centerBtn setBackgroundImage:imgbg forState:UIControlStateNormal];
//}

-(void)dealloc
{
    self.leftBtn = nil;
    self.rightBtn = nil;
    self.centerBtn = nil;
    
    self.indexLabel = nil;
    
    [super dealloc];
}

@end
