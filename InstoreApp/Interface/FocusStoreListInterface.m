//
//  FocusStoreListInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusStoreListInterface.h"
#import "JSONKit.h"
#import "FocusStoreModel.h"

@implementation FocusStoreListInterface

-(void)getFocusStoreListWithAmout:(NSInteger)amount Page:(NSInteger)page Caregory:(NSString *)category{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/store/focus_list"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"amount":[NSString stringWithFormat:@"%d",amount],
                  @"page":[NSString stringWithFormat:@"%d",page],
                  @"category":category == nil ? @"Department" : category};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Store-Focus-Add-List
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
        NSInteger currentPage = 0;
        NSInteger storeCount = 0;
        BOOL recommend = NO;
        NSMutableArray *resultList = [NSMutableArray array];
        if (totalCount  > 0) {
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            storeCount = [[jsonObj objectForKey:@"storeCount"] integerValue];
            NSString *recommendStr = [jsonObj objectForKey:@"recommend"];
            if ([recommendStr isEqualToString:@"on"]) {
                recommend = YES;
            }
            NSArray *listArray = [jsonObj objectForKey:@"list"];
            if (listArray) {
                for (NSDictionary *dict in listArray) {
                    FocusStoreModel *focusStoreModel = [[FocusStoreModel alloc]initWithJsonMap:dict];
                    [resultList addObject:focusStoreModel];
                    [focusStoreModel release];
                }
            }
        }
        if ([_delegate respondsToSelector:@selector(getFocusStoreListDidFinished:totalCount:currentPage:storeCount:recommend:)]) {
            [_delegate getFocusStoreListDidFinished:resultList totalCount:totalCount currentPage:currentPage storeCount:storeCount recommend:recommend];
        }        
    }else{
        if ([_delegate respondsToSelector:@selector(getFocusStoreListDidFailed:)]) {
            [_delegate getFocusStoreListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getFocusStoreListDidFailed:)]) {
        [self.delegate getFocusStoreListDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}

@end
