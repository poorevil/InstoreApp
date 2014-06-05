//
//  Static.h
//  InstoreApp
//
//  Created by hanchao on 14-6-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Static : NSObject

+ (NSString *)documentsPath;

+ (BOOL)createDirectory:(NSString *)path ;

@end
