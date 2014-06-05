//
//  ImageMetadata.m
//  InstoreApp
//
//  Created by hanchao on 14-6-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ImageMetadata.h"

@implementation ImageMetadata

-(id)initWithLine:(NSString *)link
{
    if (self = [super init]) {
        self.link = link;
        self.filename = [link lastPathComponent];
    }
    
    return self;
}

-(BOOL)hasCache
{
    //TODO:test if has cache
    
    return NO;
}

- (BOOL)isEqual:(id)object {
    
    if (object == self) return YES;
    if (![object isKindOfClass:[ImageMetadata class]]) return NO;
    ImageMetadata *other = (ImageMetadata *)object;
    
    return [self.link isEqualToString:other.link];
}

-(NSString *)cachePath
{
    [Static createDirectory:kImageTempDir];
    
    if (_cachePath == nil) {
        
        NSString *theFileCachePath = [kImageTempDir stringByAppendingFormat:@"/%@", self.filename];
        _cachePath = [theFileCachePath retain];
    }

	return _cachePath;
}

-(void)dealloc
{
    self.link = nil;
    self.cachePath = nil;
    self.filename = nil;
    
    [super dealloc];
}

@end
