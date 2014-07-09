//
//  CouponViewInterface.m
//  InstoreApp
//
//  Created by hanchao on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponViewInterface.h"
#import "CouponModel.h"
#import "JSONKit.h"

@implementation CouponViewInterface

- (void)getCouponViewListByPage:(NSInteger)page amount:(NSInteger)amount
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon/index",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Promotion-List
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        /*
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];//结果集
        NSMutableArray *otherGroupKeysOrder = [NSMutableArray array];//其他组的顺序，记录了所有key的名字
        [resultDict setObject:otherGroupKeysOrder forKey:@"otherGroupKeysOrder"];
        
        NSInteger totalCount = 0;
        NSInteger currentPage = 0;
        NSInteger focusCount = 0;
        if (jsonObj) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            focusCount = [[jsonObj objectForKey:@"focusCount"] integerValue];
            //关注的商户的优惠
            NSArray *listArray = [jsonObj objectForKey:@"list"];
            if (listArray) {
                NSMutableArray *resultList = [NSMutableArray array];
                for (NSDictionary *dict in listArray) {
                    [resultList addObject:[[[CouponModel alloc] initWithJsonMap:dict] autorelease]];
                }
                [resultDict setObject:@{@"itemlist":resultList,
                                        @"categoryTitle":@"我关注的品牌优惠",
                                        @"categoryId":@"0"}
                               forKey:@"list"];
            }else{
                [resultDict setObject:@{@"itemlist":@[],
                                        @"categoryTitle":@"我关注的品牌优惠",
                                        @"categoryId":@"0"}
                               forKey:@"list"];
            }
//            //可能感兴趣的，最多6条
//            NSArray *recommendArray = [jsonObj objectForKey:@"list_recommend"];
//            if (recommendArray) {
//                NSMutableArray *resultList = [NSMutableArray array];
//                for (NSDictionary *dict in recommendArray) {
//                    [resultList addObject:[[[CouponModel alloc] initWithJsonMap:dict] autorelease]];
//                }
//                [resultDict setObject:@{@"itemlist":resultList,
//                                        @"categoryTitle":@"你可能感兴趣的优惠",
//                                        @"categoryId":@"0"}
//                               forKey:@"list_recommend"];
//                [otherGroupKeysOrder addObject:@"list_recommend"];
//            }
//            //按分类显示优惠，每组最多4条
//            NSArray *categoryArray = [jsonObj objectForKey:@"list_category"];
//            if (categoryArray) {
//                for (NSDictionary *groupDict in categoryArray) {
//                    NSString *catgegoryTitle = [groupDict objectForKey:@"categoryTitle"];
//                    NSString *categoryId = [groupDict objectForKey:@"categoryId"];
//                    NSArray *groupList = [groupDict objectForKey:@"list"];
//                    NSMutableArray *resultList = [NSMutableArray array];
//                    for (NSDictionary *dict in groupList) {
//                        [resultList addObject:[[[CouponModel alloc] initWithJsonMap:dict] autorelease]];
//                    }
//                    NSString *keyName = [NSString stringWithFormat:@"list_orther_%@",categoryId];
//                    [resultDict setObject:@{@"itemlist":resultList,
//                                            @"categoryTitle":catgegoryTitle,
//                                            @"categoryId":categoryId}
//                                   forKey:keyName];
//                    [otherGroupKeysOrder addObject:keyName];
//                }
//            }
         */
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
        NSInteger pageSize;
        NSInteger currentPage;
        NSInteger focusCount;
        NSMutableArray *resultArray = [NSMutableArray array];
        if (totalCount) {
            pageSize = [[jsonObj objectForKey:@"pageSize"] integerValue];
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            focusCount = [[jsonObj objectForKey:@"focusCount"] integerValue];
            
            NSArray *listArray = [jsonObj objectForKey:@"list"];
            for (NSDictionary *dict in listArray) {
                CouponModel *couponModel = [[CouponModel alloc]initWithJsonMap:dict];
                [resultArray addObject:couponModel];
                [couponModel release];
            }
        }
        if ([self.delegate respondsToSelector:@selector(getCouponViewListDidFinished:focusCount:totalCount:currentPage:)]) {
            [self.delegate getCouponViewListDidFinished:resultArray
                                             focusCount:focusCount
                                             totalCount:totalCount
                                            currentPage:currentPage];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(getCouponViewListDidFailed:)]) {
            [self.delegate getCouponViewListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getCouponViewListDidFailed:)]) {
        [self.delegate getCouponViewListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
