//
//  MessageINterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MessageInterface.h"
#import "MessageModel.h"
#import "JSONKit.h"

@implementation MessageInterface

-(void)getMessageInterfaceListByPage:(NSInteger)page amount:(NSInteger)amount{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/msg"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Messages
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
        NSInteger currentPage = 0;
        NSMutableArray *resultList = [NSMutableArray array];
        if (totalCount > 0) {
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            
            NSArray *list = [jsonObj objectForKey:@"list"];
            if (list) {
                for (NSDictionary *dict in list) {
                    MessageModel *messageModel = [[MessageModel alloc]initWithJsonMap:dict];
                    [resultList addObject:messageModel];
                    [messageModel release];
                }
            }
        }
        if ([self.delegate respondsToSelector:@selector(getMessageInterfaceListDidFinished:totalCount:currentPage:)]) {
            [self.delegate getMessageInterfaceListDidFinished:resultList
                                             totalCount:totalCount
                                            currentPage:currentPage];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(getMessageInterfaceListDidFailed:)]) {
            [self.delegate getMessageInterfaceListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getMessageInterfaceListDidFailed:)]) {
        [self.delegate getMessageInterfaceListDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}

@end
