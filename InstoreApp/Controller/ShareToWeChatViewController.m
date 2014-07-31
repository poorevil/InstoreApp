//
//  ShareToWeChatViewController.m
//  WeChatDemo
//
//  Created by Mac on 14-7-31.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ShareToWeChatViewController.h"



#define DeviceHeight [UIScreen mainScreen].bounds.size.height



@interface ShareToWeChatViewController ()

@end

@implementation ShareToWeChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShare1:(UIButton *)sender {
//    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
//        SendMessageToWXReq *sendMessage = [[SendMessageToWXReq alloc] init];
//        sendMessage.text = @"分享测试";
//        sendMessage.bText = YES;
//        sendMessage.scene = WXSceneSession;
//        [WXApi sendReq:sendMessage];
//        [sendMessage release];
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
//        [self showView];
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"五月天<后青春期的诗>";
        message.description = @"人群中哭着你只想变成透明的颜色\
        你再也不会梦或痛或心动了\
        你已经决定了你已经决定了\
        你静静忍着紧紧把昨天在拳心握着\
        而回忆越是甜就是越伤人\
        越是在手心留下密密麻麻深深浅浅的刀割\
        重新开始活着";
        [message setThumbImage:[UIImage imageNamed:@"icon.png"]];
        WXAppExtendObject *ext = [WXAppExtendObject object];
        ext.url = @"http://www.baidu.com";
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        
        [WXApi sendReq:req];
        [req release];
    }
}

- (IBAction)btnShare2:(UIButton *)sender {
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
//        [self showView];
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"五月天<后青春期的诗>";
        message.description = @"人群中哭着你只想变成透明的颜色\
        你再也不会梦或痛或心动了\
        你已经决定了你已经决定了\
        你静静忍着紧紧把昨天在拳心握着\
        而回忆越是甜就是越伤人\
        越是在手心留下密密麻麻深深浅浅的刀割\
        重新开始活着";
        [message setThumbImage:[UIImage imageNamed:@"icon.png"]];
        WXAppExtendObject *ext = [WXAppExtendObject object];
        ext.url = @"http://www.baidu.com";
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
        [req release];
    }
}

- (IBAction)btnCancel:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(hiddenShareView:)]) {
        [_delegate hiddenShareView:self];
    }
}

-(void)showView{

    [UIView animateWithDuration:0.3 animations:^(void){
        CGRect frame = self.view.frame;
        frame.origin.y -= DeviceHeight;
        self.view.frame = frame;
    }];
    
//    [UIView animateWithDuration:2.0 animations:^(void){
//        CGRect frame = self.contontView.frame;
//        frame.origin.y -= 208;
//        self.contontView.frame = frame;
//    }];
    
    
}
//-(void)hiddenView{
////    self.view.frame = CGRectMake(0, 0, 320, DeviceHeight);
//    [UIView animateWithDuration:0.6 animations:^(void){
//        CGRect frame = self.view.frame;
//        frame.origin.y += DeviceHeight;
//        self.view.frame = frame;
//    }];
//}

-(void)dealloc{
    self.contontView = nil;
    
    [super dealloc];
}
@end
