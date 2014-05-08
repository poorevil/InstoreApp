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

-(void)getStoreListByFloor:(NSString *)floor
                       cid:(NSInteger)cid
                     order:(NSString *)order
                    isLike:(NSInteger)isLike
                    amount:(NSInteger)amount
                      page:(NSInteger)page
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/shop",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{//@"floor":floor,
                  @"cid":[NSString stringWithFormat:@"%d",cid],
//                  @"order":order,
                  @"like":[NSString stringWithFormat:@"%d",isLike],
                  @"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    "totalCount":<总页数>,
//    "currentPage":<当前页>,
//    "list":[                         //优惠列表
//            {
//            title: '商户名称',
//            logo: '商户LOGO',
//                id: '商户ID',
//            category: '商户类型',
//            floor: '楼层',
//            storeNo: '商户房间号',
//            followerCount: '关注人数'
//            }...
//            ]                    
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
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
                    StoreModel *store = [[StoreModel alloc] initWithJsonMap:storeDict];
                    [resultList addObject:store];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getStoreListDidFinished:totalCount:currentPage:)]) {
            [self.delegate getStoreListDidFinished:resultList
                                          totalCount:totalCount
                                          currentPage:currentPage];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getStoreListDidFailed:)]) {
        [self.delegate getStoreListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

@end
