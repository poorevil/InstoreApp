//
//  BaseInterface.h
//  ZReader_HD
//
//  接口父类
//
//  Created by  on 12-3-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h" 

@protocol BaseInterfaceDelegate;

@interface BaseInterface : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic,retain) ASIHTTPRequest *request;
@property (nonatomic,retain) NSString *interfaceUrl;
@property (nonatomic,retain) NSDictionary *headers;
@property (nonatomic,retain) NSDictionary *bodys;
@property (nonatomic,retain) NSDictionary *args;        //请求参数
@property (nonatomic,retain) NSDictionary *postParams;        //post请求参数

@property (nonatomic,retain) NSString *requestMethod;//请求方式

@property (nonatomic,assign) id<BaseInterfaceDelegate> baseDelegate;

-(void)connect;

@end


@protocol BaseInterfaceDelegate <NSObject>

@required
-(void)parseResult:(ASIHTTPRequest *)request;
-(void)requestIsFailed:(NSError *)error;

@optional

@end