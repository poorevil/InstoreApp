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
        
        if (self.args) {
            NSMutableString *prams = [[NSMutableString alloc] init];
            
            for (NSString *key in self.args) {
                [prams appendFormat:@"%@=%@&",key,[self.args objectForKey:key]];
            }
            NSString *removeLastChar = [prams substringWithRange:NSMakeRange(0, [prams length]-1)];
            urlString = [NSString stringWithFormat:@"%@?%@",self.interfaceUrl ,removeLastChar];
            
            NSLog(@"urlString %@",urlString);
        }else{
            urlString = self.interfaceUrl;
        }
        
        //TODO:加密算法
        
        NSURL *url = [[NSURL alloc]initWithString:urlString];
        self.request = [ASIHTTPRequest requestWithURL:url];
        
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


@end
