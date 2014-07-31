//
//  ShareToWeChatViewController.h
//  WeChatDemo
//
//  Created by Mac on 14-7-31.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXApi.h"
#import "WXApiObject.h"

@protocol ShareToWeChatDeleate <NSObject>

-(void)hiddenShareView:(UIViewController *)vc;

@end

@interface ShareToWeChatViewController : UIViewController<WXApiDelegate>

@property (assign, nonatomic) id<ShareToWeChatDeleate>delegate;

- (IBAction)btnShare1:(UIButton *)sender;
- (IBAction)btnShare2:(UIButton *)sender;
- (IBAction)btnCancel:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIImageView *contontView;

-(void)showView;
//-(void)hiddenView;

@end
