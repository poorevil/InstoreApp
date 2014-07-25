//
//  AppDelegate.h
//  InstoreApp
//
//  Created by han chao on 14-3-17.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UITabBarController *tabBarController;

-(void)initWindow;
@end
