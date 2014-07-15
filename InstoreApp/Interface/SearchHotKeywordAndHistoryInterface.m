//
//  SearchHotKeywordInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SearchHotKeywordAndHistoryInterface.h"
#import "JSONKit.h"

@implementation SearchHotKeywordAndHistoryInterface

-(void)getSearchHotKeywordAndHistoryList{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/search/keyword"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Search-Keyword
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    NSArray *hot = nil;
    NSArray *history = nil;
    if (jsonObj) {
        hot = [jsonObj objectForKey:@"keyword_hot"];
        history = [jsonObj objectForKey:@"keyword_history"];
    if (_delegate && [_delegate respondsToSelector:@selector(getSearchHotKeywordAndHistoryListDidFinished:AndHistory:)]) {
            [_delegate getSearchHotKeywordAndHistoryListDidFinished:hot AndHistory:history];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(getSearchHotKeywordAndHistoryListListDidFailed:)]) {
            [_delegate getSearchHotKeywordAndHistoryListListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getSearchHotKeywordAndHistoryListListDidFailed:)]) {
        [self.delegate getSearchHotKeywordAndHistoryListListDidFailed:@"获取失败！(response empty)"];
    }
}
-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}

@end
