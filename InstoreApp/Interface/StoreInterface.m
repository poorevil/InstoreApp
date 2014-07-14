//
//  StoreInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreInterface.h"
#import "JSONKit.h"
#import "StoreModel.h"

@implementation StoreInterface

-(void)getStoreListByAmount:(NSInteger)amount
                       page:(NSInteger)page
                   category:(NSString *)category
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/store",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    self.category = category;
    [self connect];
}

//复杂查询
-(void)getStoreListByFloorId:(NSInteger )fid
                         cid:(NSInteger)cid
                  buildingId:(NSInteger)bid
                       order:(NSString *)order
                    category:(NSString *)category //商户大分类 默认"Department"
                      amount:(NSInteger)amount
                        page:(NSInteger)page
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/store",BASE_INTERFACE_DOMAIN, MALL_CODE];
    NSMutableDictionary *requestArgs = [NSMutableDictionary dictionaryWithDictionary:@{@"floorId":[NSString stringWithFormat:@"%d",fid],
                  @"cid":[NSString stringWithFormat:@"%d",cid],
                  @"buildingId": [NSString stringWithFormat:@"%d",bid],
                  @"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]}];
    if (order) {
        [requestArgs setObject:order forKey:@"order"];
    }
    if (category) {
        [requestArgs setObject:category forKey:@"category"];
    }
    
    self.args = requestArgs;
    self.baseDelegate = self;
    self.category = category;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Store-List
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSMutableArray *resultList = [NSMutableArray array];
        NSInteger totalCount = 0;
        NSInteger currentPage = 0;
        NSInteger storeCount = 0;
        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            storeCount = [[jsonObj objectForKey:@"storeCount"] integerValue];
            
            NSArray *storesArray = [jsonObj objectForKey:@"list"];
            if (storesArray) {
                for (NSDictionary *storeDict in storesArray) {
                    StoreModel *store = [[[StoreModel alloc] initWithJsonMap:storeDict] autorelease];
                    [resultList addObject:store];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getStoreListDidFinished:totalCount:storeCount:currentPage:category:)]) {
            [self.delegate getStoreListDidFinished:resultList
                                          totalCount:totalCount
                                        storeCount:storeCount
                                       currentPage:currentPage
                                          category:self.category];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getStoreListDidFailed:)]) {
        [self.delegate getStoreListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    self.category = nil;
    
    [super dealloc];
}

@end
