//
//  DeleteBankCardInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-4.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DeleteBankCardInterface.h"
#import "JSONKit.h"

@implementation DeleteBankCardInterface

-(void)deleteBankCardWithBankId:(NSInteger)bankId{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/bank/delete"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"bankId":[NSString stringWithFormat:@"%d",bankId]};
    self.baseDelegate = self;
    [self connect];
}

-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        DebugLog(@"%@",jsonObj);
    }
}

-(void)requestIsFailed:(NSError *)error{
    
}

@end
