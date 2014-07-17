//
//  FocusedStoreListInterface.m
//  InstoreApp
//
//  Created by evil on 14-7-14.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusedStoreListInterface.h"
#import "JSONKit.h"
#import "StoreModel.h"

@implementation FocusedStoreListInterface

-(void)getFocusedStoreListByAmount:(NSInteger)amount page:(NSInteger)page
                             order:(NSString *)order category:(NSString *)category
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/store"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    NSMutableDictionary *requestArgs = [NSMutableDictionary dictionaryWithDictionary:@{@"amount":[NSString stringWithFormat:@"%d",amount],@"page":[NSString stringWithFormat:@"%d",page]}];
    if (order) {
        [requestArgs setObject:order forKey:@"order"];
    }
    
    if (category) {
        [requestArgs setObject:category forKey:@"category"];
    }
    
    self.args = requestArgs;
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Store-Focused
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
        NSInteger currentPage = 0;
        NSInteger storeCount = 0;
        NSMutableArray *resultList = [NSMutableArray array];
        if (totalCount  > 0) {
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            storeCount = [[jsonObj objectForKey:@"storeCount"] integerValue];
            
            NSArray *listArray = [jsonObj objectForKey:@"list"];
            if (listArray) {
                for (NSDictionary *dict in listArray) {
                    StoreModel *storeModel = [[StoreModel alloc]initWithJsonMap:dict];
                    storeModel.isFocus = YES;
                    [resultList addObject:storeModel];
                    [storeModel release];
                }
            }
        }
        if (_delegate && [_delegate respondsToSelector:@selector(getFocusedStoreListDidFinished:totalCount:currentPage:storeCount:)]) {
            [_delegate getFocusedStoreListDidFinished:resultList
                                           totalCount:totalCount
                                          currentPage:currentPage
                                           storeCount:storeCount];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(getFocusedStoreListDidFailed:)]) {
            [_delegate getFocusedStoreListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getFocusedStoreListDidFailed:)]) {
        [self.delegate getFocusedStoreListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}
-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}
@end
