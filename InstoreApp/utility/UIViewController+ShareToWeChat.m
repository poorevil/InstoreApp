//
//  UIViewController+ShareToWeChat.m
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "UIViewController+ShareToWeChat.h"

@implementation UIViewController (ShareToWeChat)

-(void)shareToWeChatWithTitle:(NSString *)title Description:(NSString *)description LinkURL:(NSString *)linkURL{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        [message setThumbImage:[UIImage imageNamed:@"Icon_114.png" ]];
        message.title = title;
        message.description = description;
        
        WXAppExtendObject *ext = [WXAppExtendObject object];
        ext.url = linkURL;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
        [req release];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有按照微信，请安装微信后再进行分享" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
@end
