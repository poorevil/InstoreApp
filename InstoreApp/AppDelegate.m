//
//  AppDelegate.m
//  InstoreApp
//
//  Created by han chao on 14-3-17.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MeViewController.h"
#import "ShopViewController.h"
#import "YouhuiViewController.h"
#import "ServiceViewController.h"
#import "CustomNavigationController.h"

#import "HTTPAccess.h"
#import "IconDictManager.h"

static NSString* szClientId = @"2014040301";
static NSString* szClientSecret = @"ea13692f9c960a37db0086ff87e56e01";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //初始化HTTPAccess
    if (![HTTPAccess getInstanceIfInited]) {
        HTTPAccess *httpAccess = [HTTPAccess createWithId:szClientId andSecret:szClientSecret];
//        [httpAccess requestAccessTokenFromServer];
        [httpAccess requestAccessTokenFromServerSynchronously];
        NSLog(@"===========%@",[httpAccess accessToken]);
    }
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    MainViewController *mainViewVC = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    CustomNavigationController *nav1 = [[CustomNavigationController alloc] initWithRootViewController:mainViewVC];
    nav1.title = @"首页";
    
    YouhuiViewController *youhuiVC = [[YouhuiViewController alloc] initWithNibName:@"YouhuiViewController" bundle:nil];
    CustomNavigationController *nav2 = [[CustomNavigationController alloc] initWithRootViewController:youhuiVC];
    nav2.title = @"优惠劵";
    
    ServiceViewController *serviceVC = [[ServiceViewController alloc] initWithNibName:@"ServiceViewController" bundle:nil];
    CustomNavigationController *nav3 = [[CustomNavigationController alloc] initWithRootViewController:serviceVC];
    nav3.title = @"服务";
    
    ShopViewController *shopViewVC = [[ShopViewController alloc] initWithNibName:@"ShopViewController" bundle:nil];
    CustomNavigationController *nav4 = [[CustomNavigationController alloc] initWithRootViewController:shopViewVC];
    nav4.title = @"商户";
    
    MeViewController *meViewVC = [[MeViewController alloc] initWithNibName:@"MeViewController" bundle:nil];
    CustomNavigationController *nav5 = [[CustomNavigationController alloc] initWithRootViewController:meViewVC];
    nav5.title = @"我的";
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    // Assign tab bar item with titles
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    tabBarItem1.title = @"首页";
    tabBarItem2.title = @"优惠劵";
    tabBarItem3.title = @"服务";
    tabBarItem4.title = @"商户";
    tabBarItem5.title = @"我的";

    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"toolBar-btn-home.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"toolBar-btn-home.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"toolBar-btn-sale.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"toolBar-btn-sale.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"toolBar-btn-service.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"toolBar-btn-service"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"toolBar-btn-store"] withFinishedUnselectedImage:[UIImage imageNamed:@"toolBar-btn-store"]];
    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"toolBar-btn-user"] withFinishedUnselectedImage:[UIImage imageNamed:@"toolBar-btn-user"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateHighlighted];
    
//    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"home_selected.png"]
//              withFinishedUnselectedImage:[UIImage imageNamed:@"home.png"]];
//    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"maps_selected.png"]
//              withFinishedUnselectedImage:[UIImage imageNamed:@"maps.png"]];
//    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"myplan_selected.png"]
//              withFinishedUnselectedImage:[UIImage imageNamed:@"myplan.png"]];
//    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"settings_selected.png"]
//              withFinishedUnselectedImage:[UIImage imageNamed:@"settings.png"]];
//    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"settings_selected.png"]
//              withFinishedUnselectedImage:[UIImage imageNamed:@"settings.png"]];

    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar_bg.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected_bg.png"]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [HTTPAccess saveCacheData];//保存plist到文件
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
