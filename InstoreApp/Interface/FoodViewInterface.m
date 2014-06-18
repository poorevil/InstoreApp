//
//  FoodViewInterface.m
//  InstoreApp
//
//  Created by evil on 14-6-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FoodViewInterface.h"
#import "JSONKit.h"
#import "StoreModel.h"


@implementation FoodViewInterface

-(void)getFoodListByPage:(NSInteger)page amount:(NSInteger)amount
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/restaurant/store",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Restaurant-Store
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSMutableArray *resultList = [NSMutableArray array];
        NSInteger totalCount = 0;
        NSInteger currentPage = 0;
        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            
            NSArray *storesArray = [jsonObj objectForKey:@"list"];
            if (storesArray) {
                for (NSDictionary *storeDict in storesArray) {
                    StoreModel *store = [[[StoreModel alloc] initWithJsonMap:storeDict] autorelease];
                    [resultList addObject:store];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getFoodListDidFinished:totalCount:currentPage:)]) {
            [self.delegate getFoodListDidFinished:resultList
                                       totalCount:totalCount
                                      currentPage:currentPage];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(getFoodListDidFailed:)]) {
            [self.delegate getFoodListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getFoodListDidFailed:)]) {
        [self.delegate getFoodListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
