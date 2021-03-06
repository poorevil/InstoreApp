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
//#import "ShopViewController.h"
#import "StoreListViewController.h"
//#import "YouhuiViewController.h"
#import "CouponViewController.h"
//#import "ServiceViewController.h"
#import "FoodViewController.h"
#import "CustomNavigationController.h"

#import "HTTPAccess.h"
#import "IconDictManager.h"

#import "InitInterface.h"

#import "GlobeModel.h"
#import "UMSocial.h"

#import "FirstViewController.h"

static NSString* szClientId = @"2014040301";
static NSString* szClientSecret = @"ea13692f9c960a37db0086ff87e56e01";

@interface AppDelegate()<InitInterfaceDelegate>

@property (nonatomic,strong) InitInterface *myInitInterface;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 友盟appKey
    [UMSocialData setAppKey:@"5385444a56240bdc070c0d4e"];
    
    //初始化微信 appkey
    [WXApi registerApp:WeChatKey];
    
    //地图初始化HTTPAccess
    if (![HTTPAccess getInstanceIfInited]) {
        HTTPAccess *httpAccess = [HTTPAccess createWithId:szClientId andSecret:szClientSecret];
//        [httpAccess requestAccessTokenFromServer];
        [httpAccess requestAccessTokenFromServerSynchronously];
        NSLog(@"===========%@",[httpAccess accessToken]);
    }
    
    [[GlobeModel sharedSingleton] initUUIDIfNeeded];
    
//    self.myInitInterface = [[[InitInterface alloc] init] autorelease];
//    self.myInitInterface.delegate = self;
//    [self.myInitInterface getInitParam];
    
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirst"];
    
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst"];
    if (!isFirst) {
        FirstViewController *vc = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil];
        self.window.rootViewController = vc;
        [vc release];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
    }else{
        [self initWindow];
    }
    
    return YES;
}

-(void)initWindow
{
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    
    MainViewController *mainViewVC = [[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil] autorelease];
    CustomNavigationController *nav1 = [[[CustomNavigationController alloc] initWithRootViewController:mainViewVC]autorelease];
    nav1.title = @"首页";
    
    CouponViewController *youhuiVC = [[[CouponViewController alloc] initWithNibName:@"CouponViewController"
                                                                             bundle:nil] autorelease];
    CustomNavigationController *nav2 = [[[CustomNavigationController alloc] initWithRootViewController:youhuiVC] autorelease];
    nav2.title = @"优惠劵";
    
    FoodViewController *foodVC = [[[FoodViewController alloc] initWithNibName:@"FoodViewController"
                                                                       bundle:nil] autorelease];
    CustomNavigationController *nav3 = [[[CustomNavigationController alloc] initWithRootViewController:foodVC] autorelease];
    nav3.title = @"服务";
    
    StoreListViewController *shopViewVC = [[[StoreListViewController alloc] initWithNibName:@"StoreListViewController" bundle:nil] autorelease];
    CustomNavigationController *nav4 = [[[CustomNavigationController alloc] initWithRootViewController:shopViewVC] autorelease];
    nav4.title = @"商户";
    
    MeViewController *meViewVC = [[[MeViewController alloc] initWithNibName:@"MeViewController" bundle:nil] autorelease];
    CustomNavigationController *nav5 = [[[CustomNavigationController alloc] initWithRootViewController:meViewVC] autorelease];
    nav5.title = @"我的";
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    // Assign tab bar item with titles
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    tabBarItem1.title = @"首页";
    tabBarItem2.title = @"优惠";
    tabBarItem3.title = @"美食";
    tabBarItem4.title = @"商户";
    tabBarItem5.title = @"我的";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"toolbar_main_icon_press.png"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"toolbar_main_icon.png"]];
    
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"toolbar_coupon_icon_press.png"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"toolbar_coupon_icon.png"]];
    
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"toolbar_food_icon_press.png"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"toolbar_food_icon"]];
    
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"toolbar_shop_icon_press"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"toolbar_shop_icon"]];
    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"toolbar_me_icon_press"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"toolbar_me_icon"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor colorWithRed:229/255.0f
                                                                       green:63/255.0f
                                                                        blue:17/255.0f
                                                                       alpha:1],
                                                       UITextAttributeTextColor,nil]
                                             forState:UIControlStateSelected];
    
//    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar_bg.png"];
//    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected_bg.png"]];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
//    return self.tabBarController;
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

-(void)dealloc
{
    self.tabBarController = nil;
    self.window = nil;
    self.myInitInterface = nil;
    
    [super dealloc];
}

#pragma mark - InitInterfaceDelegate <NSObject>
-(void)getInitParamDidFinished
{
    [self initWindow];
}

-(void)getInitParamDidFailed:(NSString *)errorMsg{
    DebugLog(@"%@",errorMsg);
    [self initWindow];
}

#pragma mark - WXApiDelegate
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}


@end
