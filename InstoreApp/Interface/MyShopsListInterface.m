//
//  MyShopsListInterface.m
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyShopsListInterface.h"
#import "JSONKit.h"
#import "StoreModel.h"

@implementation MyShopsListInterface

-(void)getMyShopsList
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/shop",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    "totalCount":<总页数>,            // **int**
//    "currentPage":<当前页>,           // **int**
//    "list":[                         //优惠列表
//            {
//            title: '商户名称',
//            logo: '商户LOGO',
//                id: '商户ID',                // **int**
//            category: {
//                id: '商户类型ID',        // **int**
//            name: '商户类型名称'
//            }
//            area: '楼区',
//            floor: '楼层',
//            roomNum: '商户房间号',
//            followerCount: '关注人数'     // **int**
//            }...
//            ]
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
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
        
        if ([self.delegate respondsToSelector:@selector(getMyShopsListDidFinished:totalAmount:currentPage:)]) {
            [self.delegate getMyShopsListDidFinished:resultList
                                                 totalAmount:totalCount
                                                 currentPage:currentPage];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getMyShopsListDidFailed:)]) {
        [self.delegate getMyShopsListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}
@end
