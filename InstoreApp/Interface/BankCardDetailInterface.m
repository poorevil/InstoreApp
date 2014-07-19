//
//  BankCardDetailInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-4.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BankCardDetailInterface.h"
#import "JSONKit.h"
#import "BankCardDetailModel.h"

@implementation BankCardDetailInterface

-(void)getBankCardDetailByPage:(NSInteger)page amount:(NSInteger)amount andBankId:(NSInteger)bandId{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/bank/promotion"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount],
                  @"bankId":[NSString stringWithFormat:@"%d",bandId]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Bank-Promotion-List
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSInteger totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
        NSInteger currentPage = 0;
        NSMutableArray *resultList = [NSMutableArray array];
        if (totalCount > 0) {
            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
            
            NSDictionary *bankDict = [jsonObj objectForKey:@"bank"];
            
            NSArray *dailyListArray = [jsonObj objectForKey:@"list"];
            if (dailyListArray) {
                for (NSDictionary *dailyList in dailyListArray) {
                    BankCardDetailModel *bankCardDetailModel = [[BankCardDetailModel alloc]initWithJsonMap:dailyList];
                    bankCardDetailModel.bank = [[BankCardModel alloc]initWithJsonMap:bankDict];
                    [resultList addObject:bankCardDetailModel];
                }                
            }
        }
        if ([self.delegate respondsToSelector:@selector(getBankCardDetailDidFinished:totalCount:currentPage:)]) {
            [self.delegate getBankCardDetailDidFinished:resultList
                                        totalCount:totalCount
                                       currentPage:currentPage];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(getBankCardDetailDidFailed:)]) {
            [self.delegate getBankCardDetailDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getBankCardDetailDidFailed:)]) {
        [self.delegate getBankCardDetailDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}
@end
