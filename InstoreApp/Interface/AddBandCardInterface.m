//
//  AddBandCardInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "AddBandCardInterface.h"
#import "JSONKit.h"
#import "AddBankCardModel.h"

@implementation AddBandCardInterface

-(void)getAddBankCardByPage:(NSInteger)page amount:(NSInteger)amount{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/bank/add"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"page":[NSString stringWithFormat:@"%d",page],
                  @"amount":[NSString stringWithFormat:@"%d",amount]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Bank-Add
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
            
            NSArray *cardListArray = [jsonObj objectForKey:@"list"];
            if (cardListArray) {
                for (NSDictionary *cardList in cardListArray) {
                    AddBankCardModel *addBackCardModel = [[AddBankCardModel alloc]initWithJsonMap:cardList];
                    [resultList addObject:addBackCardModel];
                    [addBackCardModel release];
                }
            }
        }
        if ([self.delegate respondsToSelector:@selector(getAddBankCardDidFinished:totalCount:currentPage:)]) {
            [self.delegate getAddBankCardDidFinished:resultList
                                       totalCount:totalCount
                                      currentPage:currentPage];
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(getAddBankCardDidFailed:)]) {
            [self.delegate getAddBankCardDidFailed:@"获取失败！(response empty)"];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getAddBankCardDidFailed:)]) {
        [self.delegate getAddBankCardDidFailed:@"获取失败！(response empty)"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}
@end
