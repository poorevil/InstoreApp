//
//  UIViewController+ShareToWeChat.h
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface UIViewController (ShareToWeChat)

-(void)shareToWeChatWithTitle:(NSString *)title Description:(NSString *)description LinkURL:(NSString *)linkURL;

@end
