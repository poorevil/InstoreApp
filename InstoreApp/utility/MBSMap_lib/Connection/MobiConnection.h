//
//  MobiConnection.h
//  SmartMall
//
//  Created by dujianping on 11/9/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "CacheConfiguration.h"

@interface MobiConnection : NSObject {
    ASIHTTPRequest *request;
    int  statusCode;
}

@property (nonatomic) int retryCount;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) int statusCode;
@property (nonatomic, assign) BOOL hasError;
@property (nonatomic) BOOL needSaveLocalTimeStamp;
@property (nonatomic) BOOL needEncrypt;
@property (nonatomic) BOOL needAccessToken;
@property (nonatomic) BOOL fRegetAccessToken;
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, copy) NSString *errorDetail;
@property (nonatomic, copy) NSString *pageFileName;
@property (nonatomic, copy) NSString *tag;

- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction;
- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withCache:(NSString*)cacheName withTimeOut:(NSTimeInterval)timeOutSeconds;
- (void) cancel;

- (void) asyncGet:(NSString *)url;
- (void) asyncGet:(NSString *)url withTag:(NSString*)strTag;

- (void) asyncPost:(NSString *)url
            params:(NSMutableDictionary *)params 
         withImage:(NSData *)imageData;

- (void) syncPost:(NSString *)url 
       forHeader:(NSMutableDictionary *)headerDict 
     forHTTPBody:(NSMutableData *)body;
- (NSData *)syncGet:(NSString *)url andStatusCode: (NSInteger *)pStatusCode;

- (void)saveDataToCache:(ASIHTTPRequest *)_request;
- (id)initWithDelegate:(id)aDelegate action:(SEL)anAction withCache:(NSString*)cacheName;
@end
