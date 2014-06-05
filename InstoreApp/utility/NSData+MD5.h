//
//  NSData+MD5.h
//  InstoreApp
//
//  Created by hanchao on 14-6-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MD5)

- (NSString *)MD5EncodedString;
- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key;
- (NSString *)base64EncodedString;
+ (NSData *)dataFromBase64String:(NSString *)aString;


@end
