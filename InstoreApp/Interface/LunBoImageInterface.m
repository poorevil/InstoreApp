//
//  LunBoImageInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-14.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "LunBoImageInterface.h"
#import "JSONKit.h"
#import "CouponModel.h"

@implementation LunBoImageInterface

-(void)getLunBoImageListWithPos:(NSInteger)pos{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/slide_show"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"pos":[NSString stringWithFormat:@"%d",pos]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Slide-Show
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
       
        NSMutableArray *resultList = [NSMutableArray array];
        if (totalCount  > 0) {
            NSArray *listArray = [jsonObj objectForKey:@"list"];
            if (listArray) {
                for (NSDictionary *dict in listArray) {
                    CouponModel *couponModel = [[CouponModel alloc]initWithJsonMap:dict];
                    [resultList addObject:couponModel];
                    [couponModel release];
                }
            }
        }
        if (_delegate && [_delegate respondsToSelector:@selector(getLunBoImageListDidFinished:totalCount:)]) {
            [_delegate getLunBoImageListDidFinished:resultList totalCount:totalCount];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(getLunBoImageListDidFailed:)]) {
            [_delegate getLunBoImageListDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getLunBoImageListDidFailed:)]) {
        [self.delegate getLunBoImageListDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}

@end
