//
//  StoreDetailInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreDetailInterface.h"
#import "JSONKit.h"
#import "StoreModel.h"

@implementation StoreDetailInterface

-(void)getStoreDetailByShopId:(NSInteger)shopId
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/store/detail",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"id":[NSString stringWithFormat:@"%d",shopId]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Store-Detail
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        StoreModel *store = nil;
        if (jsonObj) {
            store = [[[StoreModel alloc] initWithJsonMap:jsonObj] autorelease];
        }
        
        if ([self.delegate respondsToSelector:@selector(getStoreDetailDidFinished:)]) {
            [self.delegate getStoreDetailDidFinished:store];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getStoreDetailDidFailed:)]) {
        [self.delegate getStoreDetailDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
