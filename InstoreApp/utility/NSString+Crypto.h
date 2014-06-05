//
//  NSString+Crypto.h
//  TwitterRestAPI_1.1
//
//  Created by admin on 24.09.13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import	<CommonCrypto/CommonHMAC.h>
#import	<CommonCrypto/CommonDigest.h>

#import "Base64.h"

@interface NSString (Crypto)

//RAW
- (NSData *)MD5;
- (NSData *)SHA1;
- (NSData *)HMAC_MD5        :(NSString *)hmacKey;
- (NSData *)HMAC_SHA1       :(NSString *)hmacKey;

//INTERPRET Base64
- (NSString *)MD5_x64;
- (NSString *)SHA1_x64;
- (NSString *)HMAC_MD5_x64  :(NSString *)hmacKey;
- (NSString *)HMAC_SHA1_x64 :(NSString *)hmacKey;

//INTERPRET HEX
- (NSString *)MD5_HEX;
- (NSString *)SHA1_HEX;
- (NSString *)HMAC_MD5_HEX  :(NSString *)hmacKey;
- (NSString *)HMAC_SHA1_HEX :(NSString *)hmacKey;


- (NSString *)MD5EncodedString;
@end
