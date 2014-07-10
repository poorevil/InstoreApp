//
//  SetStoreFocusRecommend.m
//  InstoreApp
//
//  Created by Mac on 14-7-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SetStoreFocusRecommend.h"

@implementation SetStoreFocusRecommend

//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Setting
-(void)setStoreFocusRecomend:(BOOL)onOrOff{
    if (onOrOff) {  //开启
        self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/setting/store_focus_recommend/on"
                             ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    }else{
        self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo/setting/store_focus_recommend/off"
                             ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    }
    [self connect];
}
@end
