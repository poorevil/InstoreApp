//
//  ImageMetaDataLoader.m
//  ParseDurtyHtml
//
//  Created by han chao on 12-12-12.
//  Copyright (c) 2012年 hanchao. All rights reserved.
//

#import "ImageMetaDataLoader.h"
#import <ImageIO/ImageIO.h>

@implementation ImageMetaDataLoader

-(id)initWithImageUrl:(NSURL *) url
{
    self = [super init];
    
    if (self)
    {
        self.imageUrl = url;
    }
    
    return self;
}

-(void)loadImageMateDate
{
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)self.imageUrl, NULL);
    if (imageSource == NULL) {
        // Error loading image
        //TODO:抛出异常
        return;
    }
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:NO], (NSString *)kCGImageSourceShouldCache,
                                 nil];
    CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, (CFDictionaryRef)options);
    
    CFRelease(imageSource);
    
    if (imageProperties) {
        
        //获取图片宽高
        NSNumber *width = (NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
        self.width = width.floatValue;
        
        NSNumber *height = (NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
        self.height = height.floatValue;
//        NSLog(@"Image dimensions: %@ x %@ px", width, height);
        
        //获取图片拍摄日期
        CFDictionaryRef exif = CFDictionaryGetValue(imageProperties, kCGImagePropertyExifDictionary);
        if (exif) {
            NSString *dateTakenString = (NSString *)CFDictionaryGetValue(exif, kCGImagePropertyExifDateTimeOriginal);
            self.exifInfo = dateTakenString;
            
//            NSLog(@"Date Taken: %@", dateTakenString);
        }
        
        //获取拍摄设备信息
        CFDictionaryRef tiff = CFDictionaryGetValue(imageProperties, kCGImagePropertyTIFFDictionary);
        if (tiff) {
            NSString *cameraModel = (NSString *)CFDictionaryGetValue(tiff, kCGImagePropertyTIFFModel);
            self.tiffInfo = cameraModel;
//            NSLog(@"Camera Model: %@", cameraModel);
        }
        
        //获取GPS相关信息
        CFDictionaryRef gps = CFDictionaryGetValue(imageProperties, kCGImagePropertyGPSDictionary);
        if (gps) {
            NSString *latitudeString = (NSString *)CFDictionaryGetValue(gps, kCGImagePropertyGPSLatitude);
            self.gpsLatitudeString = latitudeString;
            
            NSString *latitudeRef = (NSString *)CFDictionaryGetValue(gps, kCGImagePropertyGPSLatitudeRef);
            self.gpsLatitudeRef = latitudeRef;
            
            NSString *longitudeString = (NSString *)CFDictionaryGetValue(gps, kCGImagePropertyGPSLongitude);
            self.gpsLongitudeString = longitudeString;
            
            NSString *longitudeRef = (NSString *)CFDictionaryGetValue(gps, kCGImagePropertyGPSLongitudeRef);
            self.gpsLongitudeRef = longitudeRef;
            
//            NSLog(@"GPS Coordinates: %@ %@ / %@ %@", longitudeString, longitudeRef, latitudeString, latitudeRef);
        }
        
        CFRelease(imageProperties);
    }
}


-(void)dealloc
{
    self.imageUrl = nil;
    
    self.exifInfo = nil;
    
    self.tiffInfo = nil;
    
    self.gpsLatitudeString = nil;
    self.gpsLatitudeRef = nil;
    self.gpsLongitudeString = nil;
    self.gpsLongitudeRef = nil;
    
    [super dealloc];
}
@end
