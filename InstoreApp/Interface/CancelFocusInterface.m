//
//  CancelFocusInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CancelFocusInterface.h"

@implementation CancelFocusInterface

-(void)sendCancelFocusCouponID:(NSInteger)couponid
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/coupon/focus"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"couponid":[NSString stringWithFormat:@"%d",couponid]};
    self.requestMethod = @"DELETE";
    self.baseDelegate = self;
    [self connect];
}

-(void)parseResult:(ASIHTTPRequest *)request{
    
}
-(void)requestIsFailed:(NSError *)error{
    
}
@end
