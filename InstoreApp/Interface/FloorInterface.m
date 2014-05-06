//
//  FloorInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FloorInterface.h"
#import "JSONKit.h"
#import "FloorModel.h"

@implementation FloorInterface

-(void)getFloorListByPage:(NSInteger)page amount:(NSInteger)amount
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/shop/floor",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    "totalCount":<总页数>,
//    "currentPage":<当前页>,
//    "floors":[                         //优惠列表
//              {
//                  id: 'ID',
//              name: '名称'
//              },
//              {
//                  id: 'ID',
//              name: '名称'
//              },
//              ...
//              ]                    
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
                for (NSDictionary *floorDict in storesArray) {
                    FloorModel *floor = [[FloorModel alloc] initWithJsonMap:floorDict];
                    [resultList addObject:floor];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getFloorListDidFinished:totalCount:currentPage:)]) {
            [self.delegate getFloorListDidFinished:resultList
                                        totalCount:totalCount
                                       currentPage:currentPage];
        }
    }

}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getFloorListDidFailed:)]) {
        [self.delegate getFloorListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

@end
