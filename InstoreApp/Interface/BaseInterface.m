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
#import "JSONKit.h"

@interface BaseInterface()

@property (nonatomic,strong) NSMutableDictionary *requestArgs;

//@property (nonatomic, assign) NSInteger retryInitTimes;//init接口重试次数
@end

@implementation BaseInterface

@synthesize baseDelegate = _baseDelegate , request = _request;
@synthesize interfaceUrl = _interfaceUrl , headers = _headers , bodys = _bodys;

//-(id)init
//{
//    if (self = [super init]) {
//        self.retryInitTimes = 0;
//    }
//    
//    return self;
//}

-(void)connect {
    if (self.interfaceUrl) {
        
//        //设置缓存机制
//        [[InterfaceCache sharedCache] setShouldRespectCacheControlHeaders:NO];
//        [self.request setDownloadCache:[InterfaceCache sharedCache]];
//        [self.request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy | ASIFallbackToCacheIfLoadFailsCachePolicy];
//        [self.request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];

//        if ([self.interfaceUrl rangeOfString:@"init/"].location == NSNotFound) {
            if (![GlobeModel sharedSingleton].runtimeModel.mallCode) {//TODO:暂时用mallCode判断是否需要调用init接口
                [self fetchInitParam];
                return;
            }
//        }
        
        [self.request setTimeOutSeconds:15];

        if (self.headers) {
            for (NSString *key in self.headers) {
                [self.request addRequestHeader:key value:[self.headers objectForKey:key]];
                
            }
        }
        
        NSString *urlString = nil;
        
        [self handleRequestParameter];
        
        if (self.requestArgs) {
            NSMutableString *prams = [[[NSMutableString alloc] init] autorelease];
            for (NSString *key in self.requestArgs) {
                [prams appendFormat:@"%@=%@&",key,[self.requestArgs objectForKey:key]];
            }
            NSString *removeLastChar = [prams substringWithRange:NSMakeRange(0, [prams length]-1)];
            urlString = [NSString stringWithFormat:@"%@?%@",self.interfaceUrl ,removeLastChar];
            
        }else{
            urlString = self.interfaceUrl;
        }
        
        urlString = [self URLEncodedString:urlString];
        NSLog(@"urlString %@",urlString);
        
        //TODO:加密算法
        
        NSURL *url = [[[NSURL alloc]initWithString:urlString] autorelease];
        
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

-(void)fetchInitParam
{
    [[GlobeModel sharedSingleton] initUUIDIfNeeded];
    
    [self.requestArgs setObject:[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]] forKey:@"timestamp"];
    [self.requestArgs setObject:[GlobeModel sharedSingleton].userId forKey:@"userid"];
    [self.requestArgs setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"v"];
    
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@init/%@?userid=%@&v=%@&timestamp=%@",
                                                                                   BASE_INTERFACE_DOMAIN,
                                                                                   MALL_CODE,
                                                                                   [GlobeModel sharedSingleton].userId,
                                                                      [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]],
                                                                      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]]];
    [request setCompletionBlock:^{
        id jsonObj = [request.responseString objectFromJSONString];
        
        if (jsonObj) {
            @try {
                if ([jsonObj objectForKey:@"errorCode"]) {
                    [self requestFailed:request];
                    return;
                }
                
                GlobeModel *globe = [GlobeModel sharedSingleton];
                globe.runtimeModel = [[RuntimeModel alloc] initWithJsonMap:jsonObj];
                
                [self connect];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception.reason);
                
                [self requestFailed:request];
            }
        }
    }];
    [request setFailedBlock:^{
        [self requestFailed:request];
    }];
    [request startAsynchronous];
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
    if (request.responseStatusCode >= 200 && request.responseStatusCode < 300) {
//        NSString *jsonStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
//        NSLog(@"=================%@",jsonStr);
        
        [self.baseDelegate parseResult:request];
    }else{
        [self requestFailed:request];
    }
}

-(void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"-------responseStatusMessage:%@",request.responseStatusMessage);
    
    [_baseDelegate requestIsFailed:request.error];
}

-(void)dealloc {
    self.baseDelegate = nil;
    
    [self.request clearDelegatesAndCancel];
    self.request = nil;
    
    self.interfaceUrl = nil;
    self.headers = nil;
    self.bodys = nil;
    self.args = nil;
    self.postParams = nil;
    self.requestMethod = nil;
    self.requestArgs = nil;
    
    [super dealloc];
}

-(void)handleRequestParameter
{
    self.requestArgs = [NSMutableDictionary dictionary];
    [self.requestArgs addEntriesFromDictionary:self.args];
    [self.requestArgs setObject:[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]] forKey:@"timestamp"];
    [self.requestArgs setObject:[GlobeModel sharedSingleton].userId forKey:@"userid"];
    [self.requestArgs setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"v"];
    
    [self.requestArgs setObject:[self genSignString] forKey:@"sign"];
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
    
    NSString *secretKey = [[GlobeModel sharedSingleton] runtimeModel].secretKey?[[GlobeModel sharedSingleton] runtimeModel].secretKey:@"joyx";
    
    [string2Sign insertString:secretKey atIndex:0];
    [string2Sign appendString:MALL_CODE];
    
    NSLog(@"---------string2Sign:%@",string2Sign);
    NSString *sign = [string2Sign HMAC_MD5_HEX:secretKey];
    [string2Sign release];
    return [sign uppercaseString];
}

- (NSString *)URLEncodedString:(NSString *)orignUrlString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)orignUrlString,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

@end
