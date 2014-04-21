//
//  ImageDownloadCell.h
//  O2O
//
//  Created by Jacky on 11-11-11.
//  Copyright 2011年 __www.widitu.net__. All rights reserved.
//  该文件主要用于 显示图片时应用cache的tableviewCell控件  

#import <UIKit/UIKit.h>
#import "ImageDownloaderImpl.h"

@interface KeyValue : NSObject {

    NSString *url_; 
    UIImageView *imageView_; 
}

@property(nonatomic,retain) NSString *url; 
@property(nonatomic,retain) UIImageView *imageView; 

@end

//--------------------------------------------------------------------
@interface ImageDownloadService : NSObject<ImageDownloaderDelegate> {
 @private
    NSMutableArray  *imageViewArray_; 
    
    // cache the image in memory
    NSMutableDictionary *cacheImageDictionary_; 
}

@end

//--------------------------------------------------------------------
