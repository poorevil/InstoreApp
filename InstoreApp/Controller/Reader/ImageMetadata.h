//
//  ImageMetadata.h
//  InstoreApp
//
//  Created by hanchao on 14-6-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageMetadata : NSObject

@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *cachePath;
@property (nonatomic, retain) NSString *filename;
//@property (nonatomic, assign) long totalBytes;


-(id)initWithLine:(NSString *)link;
-(BOOL)hasCache;

@end
