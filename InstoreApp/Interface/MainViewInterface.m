//
//  MainViewInterface.m
//  InstoreApp
//
//  Created by evil on 14-6-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"
#import "CategoryModel.h"
#import "StoreModel.h"

@implementation MainViewInterface

-(void)getMainViewList
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/index_block",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Index-Block
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSMutableArray *resultList = [NSMutableArray array];//结果集
        NSInteger totalCount = 0;
        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            NSArray *listArray = [jsonObj objectForKey:@"list"];
            if (listArray) {
                for (NSDictionary *itemDict in listArray) {
                    NSMutableDictionary *cellDict = [NSMutableDictionary dictionary];
                    
                    NSString *dataSource = [itemDict objectForKey:@"dataSource"];
                    
                    [cellDict setObject:dataSource forKey:@"dataSource"];
                    [cellDict setObject:[itemDict objectForKey:@"title"] forKey:@"title"];
                    
                    //处理data
                    NSMutableArray *resultDataList = [NSMutableArray array];//datalist
                    [cellDict setObject:resultDataList forKey:@"data"];
                    
                    NSArray *dataList = [itemDict objectForKey:@"data"];
                    if ([dataSource isEqualToString:@"Category"]) {
                        for(NSDictionary *dict in dataList){
                            CategoryModel *cm = [[[CategoryModel alloc] initWithJsonMap:dict] autorelease];
                            [resultDataList addObject:cm];
                        }
                    }else if ([dataSource isEqualToString:@"Store"]) {
                        for(NSDictionary *dict in dataList){
                            StoreModel *sm = [[[StoreModel alloc] initWithJsonMap:dict] autorelease];
                            [resultDataList addObject:sm];
                        }
                    }else{
                        for(NSDictionary *dict in dataList){
                            CouponModel *cm = [[[CouponModel alloc] initWithJsonMap:dict] autorelease];
                            [resultDataList addObject:cm];
                            
                        }
                    }
                    
                    [resultList addObject:cellDict];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getMainViewListDidFinished:totalCount:)]) {
            [self.delegate getMainViewListDidFinished:resultList totalCount:totalCount];
        }
        
        
    }else{
        if ([self.delegate respondsToSelector:@selector(getMainViewListDidFailed:)]) {
            [self.delegate getMainViewListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getMainViewListDidFailed:)]) {
        [self.delegate getMainViewListDidFailed:
         [NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}
@end
