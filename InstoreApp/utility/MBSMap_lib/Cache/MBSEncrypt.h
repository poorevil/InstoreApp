//
//  MBSEncrypt.h
//


#import <Foundation/Foundation.h>

@interface MBSEncrypt : NSObject {
    
}
+ (NSString *)encryptString:(NSString *)oriString;
+ (NSData *)encryptData:(NSData *)data;
+ (NSData *)decryptData:(NSData *)data;
+ (NSData *)decryptOldData:(NSData *)data;

@end