//
//  SearchClearHistoryInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SearchClearHistoryInterface.h"

@implementation SearchClearHistoryInterface

//https://github.com/joyx-inc/vmall-app-ios/wiki/Search-Keyword
-(void)clearHistoty{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/search/remove_history"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
//    self.baseDelegate = self;
    self.requestMethod = @"POST";
    [self connect];
}

@end
