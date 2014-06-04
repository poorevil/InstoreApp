//
//  ImageMetaDataLoader.h
//  ParseDurtyHtml
//
//  不加载图片文件获取图片信息
//
//  Created by han chao on 12-12-12.
//  Copyright (c) 2012年 hanchao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ImageMetaDataLoader : NSObject

@property (nonatomic,retain) NSURL *imageUrl;

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

//拍照时间，如：Date Taken: 2011:03:27 11:30:30
@property (nonatomic,retain) NSString *exifInfo;

//相机信息，如：Camera Model: Canon EOS 20D
@property (nonatomic,retain) NSString *tiffInfo;

//经纬度，如：8.374788 E / 54.89472 N   NSLog(@"GPS Coordinates: %@ %@ / %@ %@", longitudeString, longitudeRef, latitudeString, latitudeRef);
@property (nonatomic,retain) NSString *gpsLatitudeString;
@property (nonatomic,retain) NSString *gpsLatitudeRef;
@property (nonatomic,retain) NSString *gpsLongitudeString;
@property (nonatomic,retain) NSString *gpsLongitudeRef;


-(id)initWithImageUrl:(NSURL *) url;
-(void)loadImageMateDate;//读取图片文件信息

@end
