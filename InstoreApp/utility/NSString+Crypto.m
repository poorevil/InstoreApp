//
//  NSString+Crypto.m
//  TwitterRestAPI_1.1
//
//  Created by admin on 24.09.13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "NSString+Crypto.h"

@implementation NSString (Crypto)

//RAW
- (NSData *)MD5
{
    const char*     data	=	[self UTF8String];
    unsigned char	hashBuffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data, strlen(data), hashBuffer);
    
    return [NSData dataWithBytes:hashBuffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSData *)SHA1
{
    const char*     data	=	[self UTF8String];
    unsigned char	hashBuffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data, strlen(data), hashBuffer);
    
    return [NSData dataWithBytes:hashBuffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSData *)HMAC_MD5        :(NSString *)hmacKey
{
    const char*     data	= [self		UTF8String];
	const char*     hashKey	= [hmacKey	UTF8String];
	unsigned char	hashBuffer[CC_MD5_DIGEST_LENGTH];
    
	CCHmac(kCCHmacAlgMD5, hashKey, strlen(hashKey), data, strlen(data), hashBuffer);
    
	return	[NSData	dataWithBytes:hashBuffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSData *)HMAC_SHA1       :(NSString *)hmacKey
{
    const char*	data	= [self		UTF8String];
	const char*	hashKey	= [hmacKey	UTF8String];
	unsigned char	hashBuffer[CC_SHA1_DIGEST_LENGTH];
    
	CCHmac(kCCHmacAlgSHA1, hashKey, strlen(hashKey), data, strlen(data), hashBuffer);
    
	return	[NSData	dataWithBytes:hashBuffer length:CC_SHA1_DIGEST_LENGTH];
}

//INTERPRET Base64
- (NSString *)MD5_x64
{
    return [[self MD5] base64EncodedString];
}

- (NSString *)SHA1_x64
{
    return [[self SHA1] base64EncodedString];
}

- (NSString *)HMAC_MD5_x64  :(NSString *)hmacKey
{
    return [[self HMAC_MD5:hmacKey] base64EncodedString];
}

- (NSString *)HMAC_SHA1_x64 :(NSString *)hmacKey
{
    return [[self HMAC_SHA1:hmacKey] base64EncodedString];
}

//INTERPRET HEX
- (NSString *)MD5_HEX
{
    const char*     data	=	[self UTF8String];
    unsigned char	hashBuffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data, strlen(data), hashBuffer);
    
    NSMutableString*    result  =   [[NSMutableString   alloc]  initWithCapacity:CC_MD5_DIGEST_LENGTH*2];
	for (int i = 0; i   < CC_MD5_DIGEST_LENGTH; i++)
		[result appendFormat:@"%02X", hashBuffer[i]];
    
	return result;
}

- (NSString *)SHA1_HEX
{
    const char*     data	=	[self UTF8String];
    unsigned char	hashBuffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data, strlen(data), hashBuffer);
    
    NSMutableString*    result  =   [[NSMutableString   alloc]  initWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
	for (int i = 0; i   < CC_SHA1_DIGEST_LENGTH; i++)
		[result appendFormat:@"%02X", hashBuffer[i]];
    
	return result;
}

- (NSString *)HMAC_MD5_HEX  :(NSString *)hmacKey
{
    const char*     data	= [self		UTF8String];
	const char*     hashKey	= [hmacKey	UTF8String];
	unsigned char	hashBuffer[CC_MD5_DIGEST_LENGTH];
    
	CCHmac(kCCHmacAlgMD5, hashKey, strlen(hashKey), data, strlen(data), hashBuffer);
    
    NSMutableString*    result  =   [[[NSMutableString   alloc]  initWithCapacity:CC_MD5_DIGEST_LENGTH*2] autorelease];
	for (int i = 0; i   < CC_MD5_DIGEST_LENGTH; i++)
		[result appendFormat:@"%02X", hashBuffer[i]];
    
	return result;
}

- (NSString *)HMAC_SHA1_HEX :(NSString *)hmacKey
{
    const char*	data	= [self		UTF8String];
	const char*	hashKey	= [hmacKey	UTF8String];
	unsigned char	hashBuffer[CC_SHA1_DIGEST_LENGTH];
    
	CCHmac(kCCHmacAlgSHA1, hashKey, strlen(hashKey), data, strlen(data), hashBuffer);
    
	NSMutableString*    result  =   [[NSMutableString   alloc]  initWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
	for (int i = 0; i   < CC_SHA1_DIGEST_LENGTH; i++)
		[result appendFormat:@"%02X", hashBuffer[i]];
    
	return result;
}

@end
