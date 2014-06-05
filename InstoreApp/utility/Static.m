//
//  Static.m
//  InstoreApp
//
//  Created by hanchao on 14-6-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "Static.h"

@implementation Static

+ (NSString *)documentsPath {
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	if ([paths count] > 0) {
		
		return [paths objectAtIndex:0];
	}
	
	return [NSHomeDirectory() stringByAppendingString:@"/Documents"];
}

+ (BOOL)createDirectory:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *fullPath = [[self documentsPath] stringByAppendingFormat:@"/%@", path];
    BOOL isDir = NO;
    BOOL isExists = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    
    if (!(isExists && isDir)) {
        
        return  [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
    } else {
        
        return YES;
    }
}

@end
