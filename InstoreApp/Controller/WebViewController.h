//
//  WebViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface WebViewController : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>

@property (retain, nonatomic) NSString *urlStr;
@property (retain, nonatomic) MBProgressHUD *hud;
@property (retain, nonatomic) IBOutlet UIWebView *myWebView;
- (IBAction)webViewGoBackAction:(UIButton *)sender;
- (IBAction)wenViewGoNextAction:(UIButton *)sender;
- (IBAction)webViewReloadAction:(UIButton *)sender;

@property (retain, nonatomic) NSString *titleStr;

@end
