//
//  ServerSpecial.h
//  SmartMall
//
//  Created by sunyifei on 12/30/11.
//  Copyright (c) 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseOperation.h"

@interface HTTPAccess : NSObject <ParseOperationDelegate, NSXMLParserDelegate> 

@property (nonatomic) int timeExpireGap;
@property (nonatomic) int lastAccessTokenTime;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL action;
@property (nonatomic) BOOL needCallDelegateAction;
@property (nonatomic) BOOL networkBad;

+ (HTTPAccess *)createWithId:(NSString*)clientId andSecret:(NSString*)clientSecret;
+ (HTTPAccess *)getInstanceIfInited;
+ (void)saveCacheData;

- (NSString *)requestAccessTokenFromServer;
- (NSString *)requestAccessTokenFromServerSynchronously;
- (BOOL)checkIfAccessTokenError:(NSData *)dataToParse;
- (NSString *)accessToken;

@end
