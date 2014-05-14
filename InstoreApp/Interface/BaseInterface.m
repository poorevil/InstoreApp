//
//  BaseInterface.m
//  ZReader_HD
//
//  接口父类
//
//  Created by  on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseInterface.h"
#import "ASIFormDataRequest.h"
#import "GlobeModel.h"
#import "RuntimeModel.h"

#import "NSString+Crypto.h"

@interface BaseInterface()

@property (nonatomic,strong) NSMutableDictionary *requestArgs;

@end

@implementation BaseInterface

@synthesize baseDelegate = _baseDelegate , request = _request;
@synthesize interfaceUrl = _interfaceUrl , headers = _headers , bodys = _bodys;

-(void)connect {
    if (self.interfaceUrl) {
        
//        //设置缓存机制
//        [[InterfaceCache sharedCache] setShouldRespectCacheControlHeaders:NO];
//        [self.request setDownloadCache:[InterfaceCache sharedCache]];
//        [self.request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy];
//        [self.request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
        
        [self.request setTimeOutSeconds:15];

        if (self.headers) {
            for (NSString *key in self.headers) {
                [self.request addRequestHeader:key value:[self.headers objectForKey:key]];
                
            }
        }
        
        NSString *urlString = nil;
        
        [self handleRequestParameter];
        
        if (self.requestArgs) {
            NSMutableString *prams = [[NSMutableString alloc] init];
            for (NSString *key in self.requestArgs) {
                [prams appendFormat:@"%@=%@&",key,[self.requestArgs objectForKey:key]];
            }
            NSString *removeLastChar = [prams substringWithRange:NSMakeRange(0, [prams length]-1)];
            urlString = [NSString stringWithFormat:@"%@?%@",self.interfaceUrl ,removeLastChar];
            
        }else{
            urlString = self.interfaceUrl;
        }
        
        
        
        NSLog(@"urlString %@",urlString);
        
        //TODO:加密算法
        
        NSURL *url = [[NSURL alloc]initWithString:urlString];
        
        if (self.postParams) {
            ASIFormDataRequest *formRequest = [ASIFormDataRequest requestWithURL:url];
            for (NSString *key in self.postParams) {
                [formRequest setPostValue:[self.postParams objectForKey:key] forKey:key];
            }
            self.request = formRequest;
        }else{
            self.request = [ASIHTTPRequest requestWithURL:url];
            
            if (self.requestMethod) {
                [self.request setRequestMethod:self.requestMethod];
            }
        }
                
        [self.request setDelegate:self];
        [self.request startAsynchronous]; 
        
    }else{
        //抛出异常
    }
}

#pragma mark - ASIHttpRequestDelegate
//- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders {
//    responseHeaders = [responseHeaders allKeytoLowerCase];
//    
//    NSString *result = [responseHeaders objectForKey:@"result"];
//    if (![result isEqualToString:@"success"]) {
//        //失败
//        if ([@"102" isEqualToString:[responseHeaders objectForKey:@"error-code"]]) {
//            //[self.request clearDelegatesAndCancel];
//            self.request = nil;
//            
//            DefaultLoginInterface * defaultLogin = [[DefaultLoginInterface alloc] init];
//            self.login = defaultLogin;
//            self.login.delegate = self;
//            [defaultLogin release];
//            [self.login doLogin];
//        }
//    }
//}

-(void)requestFinished:(ASIHTTPRequest *)request {
    [self.baseDelegate parseResult:request];
}

-(void)requestFailed:(ASIHTTPRequest *)request {
    [_baseDelegate requestIsFailed:request.error];
}


//-(void)dealloc {
//    self.baseDelegate = nil;
//    
//    [self.request clearDelegatesAndCancel];
//    self.request = nil;
//    
//    self.interfaceUrl = nil;
//    self.headers = nil;
//    self.bodys = nil;
//    
//    [super dealloc];
//}

-(void)handleRequestParameter
{
    self.requestArgs = [NSMutableDictionary dictionary];
    [self.requestArgs addEntriesFromDictionary:self.args];
    [self.requestArgs setObject:[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]] forKey:@"timestamp"];
    [self.requestArgs setObject:[GlobeModel sharedSingleton].userId forKey:@"userid"];
    [self.requestArgs setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"v"];
    
//    if ([self.interfaceUrl rangeOfString:@"init/"].location == NSNotFound) {
        [self.requestArgs setObject:[self genSignString] forKey:@"sign"];
//    }
}

-(NSString *)genSignString
{
    NSArray *sortedKeys = [[self.requestArgs allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *key1 = obj1;
        NSString *key2 = obj2;
        return [key1 compare:key2];
    }];
    
    NSMutableString *string2Sign = [[NSMutableString alloc] init];
    for (NSString *key in sortedKeys) {
        [string2Sign appendString:[NSString stringWithFormat:@"%@%@",key,[self.requestArgs objectForKey:key]]];
    }
    
    NSString *secretKey = [[GlobeModel sharedSingleton] runtimeModel].secretKey?[[GlobeModel sharedSingleton] runtimeModel].secretKey:@" ";
    
    [string2Sign insertString:secretKey atIndex:0];
    [string2Sign appendString:MALL_CODE];
    
    NSLog(@"---------string2Sign:%@",string2Sign);
    NSString *sign = [string2Sign HMAC_MD5_HEX:secretKey];
    return [sign uppercaseString];
}


@end
