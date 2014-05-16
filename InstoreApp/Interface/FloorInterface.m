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

-(void)getFloorListByAreaId:(NSInteger)areaId
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/shop/floor",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"areaId":[NSString stringWithFormat:@"%d",areaId]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    
//    "areaId":<当前楼区>,
//    "floors":[                         //楼层列表
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
        if (jsonObj) {
            NSInteger areaId = [[jsonObj objectForKey:@"totalCount"] integerValue];
            NSArray *floorsArray = [jsonObj objectForKey:@"floors"];
            if (floorsArray) {
                for (NSDictionary *floorDict in floorsArray) {
                    FloorModel *floor = [[FloorModel alloc] initWithJsonMap:floorDict];
                    [resultList addObject:floor];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getFloorListDidFinished:)]) {
            [self.delegate getFloorListDidFinished:resultList];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getFloorListDidFailed:)]) {
        [self.delegate getFloorListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

@end
