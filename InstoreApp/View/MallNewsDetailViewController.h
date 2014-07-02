//
//  MallNewsDetailViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-1.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallNewsDetailViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIWebView *myWebView;

@property (retain, nonatomic) NSString *URL;
@property (retain, nonatomic) NSString *imageUrl;

@end
