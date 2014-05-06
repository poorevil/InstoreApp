//
//  CategoryListInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CategoryListInterface.h"
#import "CategoryModel.h"
#import "JSONKit.h"

@implementation CategoryListInterface
-(void)getCategoryListByPage:(NSInteger) page amount:(NSInteger) amount
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/shop/category",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    "totalCount":<总页数>,
//    "currentPage":<当前页>,
//    "categories":[                         //优惠列表
//                  {
//                      id: '分类ID',
//                  name: '分类名称'
//                  },
//                  {
//                      id: '分类ID',
//                  name: '分类名称'
//                  },
//                  ...
//                  ]
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
            
            NSArray *categorysArray = [jsonObj objectForKey:@"categories"];
            if (categorysArray) {
                for (NSDictionary *categoryDict in categorysArray) {
                    CategoryModel *category = [[CategoryModel alloc] initWithJsonMap:categoryDict];
                    [resultList addObject:category];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getCategoryListDidFinished:totalAmount:currentPage:)]) {
            [self.delegate getCategoryListDidFinished:resultList
                                          totalAmount:totalCount
                                          currentPage:currentPage];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCategoryListDidFailed:)]) {
        [self.delegate getCategoryListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}
@end
