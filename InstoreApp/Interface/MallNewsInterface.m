//
//  MallNewsInterface.m
//  InstoreApp
//
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsInterface.h"
#import "JSONKit.h"
#import "MallNewsModel.h"

@implementation MallNewsInterface

-(void)getMallNewsByPage:(NSInteger)page amount:(NSInteger)amount
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/mall_news"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Mall-News
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = 0;
        NSInteger currentPage = 0;
        NSMutableArray *resultList = [NSMutableArray array];
        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            
            
            NSArray *newsListArray = [jsonObj objectForKey:@"list"];
            if (newsListArray) {
                for (NSDictionary *newsList in newsListArray) {
                    NSMutableDictionary *newsListItem = [NSMutableDictionary dictionary];
                    [resultList addObject:newsListItem];
                    [newsListItem setObject:[newsList objectForKey:@"template"] forKey:@"template"];
                    [newsListItem setObject:[newsList objectForKey:@"date"] forKey:@"date"];
                    NSMutableArray *articles = [NSMutableArray array];
                    [newsListItem setObject:articles forKey:@"articles"];
                    for (NSDictionary *newsDict in [newsList objectForKey:@"articles"]) {
                        MallNewsModel *mallNewsModel = [[[MallNewsModel alloc] initWithJsonMap:newsDict] autorelease];
                        [articles addObject:mallNewsModel];
                    }
                }
            }
        }
        if ([self.delegate respondsToSelector:@selector(getMallNewsDidFinished:totalCount:currentPage:)]) {
            [self.delegate getMallNewsDidFinished:resultList
                                       totalCount:totalCount
                                      currentPage:currentPage];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(getmallNewsDidFailed:)]) {
            [self.delegate getmallNewsDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getmallNewsDidFailed:)]) {
        [self.delegate getmallNewsDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}


@end
