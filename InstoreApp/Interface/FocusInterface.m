//
//  FocusInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusInterface.h"
#import "JSONKit.h"

@implementation FocusInterface

-(void)sendFocusCouponID:(NSInteger)couponid{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon/focus"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"couponid":[NSString stringWithFormat:@"%d",couponid]};
    self.requestMethod = @"PUT";
//    self.baseDelegate = self;
    [self connect];
}
//#pragma mark - BaseInterfaceDelegate
////https://github.com/joyx-inc/vmall-app-ios/wiki/Mall-News
//-(void)parseResult:(ASIHTTPRequest *)request{
////    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData]
////                                               encoding:NSUTF8StringEncoding] autorelease];
////    id jsonObj = [jsonStr objectFromJSONString];
////    
////    if (jsonObj) {
//////            if ([self.delegate respondsToSelector:@selector(getResultFromFocusToServer:)]) {
//////                [self.delegate getResultFromFocusToServer:jsonObj];
//////            }
////    }else{
////        if ([self.delegate respondsToSelector:@selector(getBankCardDetailDidFailed:)]) {
////            [self.delegate getBankCardDetailDidFailed:@"获取失败！(response empty)"];
////        }
////    }
//}
//
//-(void)requestIsFailed:(NSError *)error{
////    if (_delegate && [self.delegate respondsToSelector:@selector(getBankCardDetailDidFailed:)]) {
////        [self.delegate getBankCardDetailDidFailed:@"获取失败！(response empty)"];
////    }
//}

-(void)dealloc{
//    self.delegate = nil;
    
    [super dealloc];
}
@end
