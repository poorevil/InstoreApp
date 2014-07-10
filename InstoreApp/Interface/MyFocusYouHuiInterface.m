//
//  MyFocusYouHuiInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyFocusYouHuiInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation MyFocusYouHuiInterface

-(void)getMyFocusYouHuiListWithAmount:(NSInteger)amount Page:(NSInteger)page{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/promotion/focus"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"amount":[NSString stringWithFormat:@"%d",amount],
                  @"page":[NSString stringWithFormat:@"%d",page]};
    self.baseDelegate = self;
    [self connect];
}
#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Promotion-Focus
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
        NSInteger currentPage = 0;
        NSMutableArray *resultList = [NSMutableArray array];
        if (totalCount  > 0) {
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];

            NSArray *listArray = [jsonObj objectForKey:@"list"];
            if (listArray) {
                for (NSDictionary *dict in listArray) {
                    CouponModel *couponModel = [[CouponModel alloc]initWithJsonMap:dict];
                    [resultList addObject:couponModel];
                    [couponModel release];
                }
            }
        }
        if (_delegate && [_delegate respondsToSelector:@selector(getMyFocusYouHuiListDidFinished:totalCount:currentPage:)]) {
            [_delegate getMyFocusYouHuiListDidFinished:resultList totalCount:totalCount currentPage:currentPage];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(getMyFocusYouHuiListDidFailed:)]) {
            [_delegate getMyFocusYouHuiListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getMyFocusYouHuiListDidFailed:)]) {
        [self.delegate getMyFocusYouHuiListDidFailed:@"获取失败！(response empty)"];
    }
}
-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}

@end
