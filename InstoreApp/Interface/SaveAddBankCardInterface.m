//
//  SaveAddBankCardInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SaveAddBankCardInterface.h"
#import "JSONKit.h"
#import "GlobeModel.h"

@implementation SaveAddBankCardInterface

-(void)SaveAddBankCardWithDictionary:(NSDictionary *)dict{

    NSString *str = @"";
    for (NSString *string in [dict allKeys]) {
        str = [NSString stringWithFormat:@"%@%@,",str,string];
    }
    NSRange range = NSMakeRange(0, str.length-1);
    NSString *string = [str substringWithRange:range];
    NSDictionary *dictionary = @{@"bankId": string};
    
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/bank/add",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.requestMethod = @"POST";
    self.args = dictionary;
    self.postParams = dictionary;
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
        if (_delegate && [self.delegate respondsToSelector:@selector(getReceivedFromPoatAddBankCard:)]) {
            [self.delegate getReceivedFromPoatAddBankCard:@"success"];
        }
    }
}
-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [self.delegate respondsToSelector:@selector(getReceivedFromPoatAddBankCard:)]) {
        [self.delegate getReceivedFromPoatAddBankCard:@"0"];
    }
}

-(void)dealloc{
    self.delegate = nil;
    
    [super dealloc];
}


@end
