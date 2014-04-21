//
//  MD5.h
//
//  Created by Jacky on 11-7-1.
//  Copyright 2011年 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MD5 : NSObject {
    
}

+ (NSString *)md5:(NSString *)str; 
+ (NSString *)kmd5Str:(NSString *)str;
+ (NSData *)dataEncrypt:(NSData*)data;
+ (NSData *)dataDecrypt:(NSData*)data;

@end
