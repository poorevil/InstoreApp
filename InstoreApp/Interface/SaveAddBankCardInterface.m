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
//    NSString *urlStr = [NSString stringWithFormat:@"%@api/%@/myinfo/bank/add?timestamp=%@&userid=%@&v=%@sign=%@",BASE_INTERFACE_DOMAIN,
//                        MALL_CODE,
//                        [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970],
//                         [GlobeModel sharedSingleton].userId forKey:@"userid"],
//                         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:@"v"],
//    ];
//    
//    
//    NSURL *URL = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//    [request setHTTPMethod:@"POST"];
    NSString *str = @"";
    for (NSString *string in [dict allKeys]) {
        str = [NSString stringWithFormat:@"%@%@,",str,string];
    }
    NSRange range = NSMakeRange(0, str.length-1);
    NSString *string = [str substringWithRange:range];
    NSDictionary *dictionary = @{@"bankId": string};
    NSLog(@"%@",string);
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:data];
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSLog(@"%@",[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding]);
    
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/bank/add",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.requestMethod = @"POST";
    self.args = dictionary;
//    self.postParams = dictionary;
    self.baseDelegate = self;
    [self connect];


}

#pragma mark - BaseInterfaceDelegate
//https://github.com/joyx-inc/vmall-app-ios/wiki/Mall-News
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
                                               encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
//        NSInteger totalCount = 0;
//        NSInteger currentPage = 0;
//        NSMutableArray *resultList = [NSMutableArray array];
//        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
//            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
//            currentPage = [[jsonObj objectForKey:@"currentPage"] integerValue];
//            
//            NSArray *cardListArray = [jsonObj objectForKey:@"list"];
//            if (cardListArray) {
//                for (NSDictionary *cardList in cardListArray) {
//                    AddBankCardModel *addBackCardModel = [[AddBankCardModel alloc]initWithJsonMap:cardList];
//                    [resultList addObject:addBackCardModel];
//                    [addBackCardModel release];
//                }
//            }
//        }
//        if ([self.delegate respondsToSelector:@selector(getAddBankCardDidFinished:totalCount:currentPage:)]) {
//            [self.delegate getAddBankCardDidFinished:resultList
//                                          totalCount:totalCount
//                                         currentPage:currentPage];
//        }
//        
//    }else{
//        if ([self.delegate respondsToSelector:@selector(getAddBankCardDidFailed:)]) {
//            [self.delegate getAddBankCardDidFailed:@"获取失败！(response empty)"];
//        }
        NSLog(@"%@",jsonObj);
    }
}

-(void)requestIsFailed:(NSError *)error{
//    if (_delegate && [self.delegate respondsToSelector:@selector(getAddBankCardDidFailed:)]) {
//        [self.delegate getAddBankCardDidFailed:@"获取失败！(response empty)"];
//    }
    NSLog(@"%s",__FUNCTION__);
}


@end
