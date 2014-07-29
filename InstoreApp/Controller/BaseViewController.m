//
//  BaseViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-27.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"
#import "MainViewController.h"
#import "SearchViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
	// Do any additional setup after loading the view.
    if ([self isMemberOfClass:[MainViewController class]]) {
        
        UIView *icon = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon"]] autorelease];
        icon.frame = CGRectMake(0, 0, 30, 30);
        UIView *iconView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30 )] autorelease];
        [iconView addSubview:icon];
        
        UIBarButtonItem *iconItem = [[[UIBarButtonItem alloc] initWithCustomView:iconView] autorelease];
        NSArray *items = [NSArray arrayWithObjects:iconItem, nil];
        self.navigationItem.leftBarButtonItems = items;
        self.navigationItem.leftItemsSupplementBackButton = YES;
    }else{
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f
                                                                                 green:40.0f/255.0f
                                                                                  blue:53.0f/255.0f
                                                                                 alpha:1]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        

        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchBtn setImage:[UIImage imageNamed:@"topBar-btn-zoom-white"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(showSearchView) forControlEvents:UIControlEventTouchUpInside];
        [searchBtn sizeToFit];
        UIBarButtonItem *rightBtn = [[[UIBarButtonItem alloc] initWithCustomView:searchBtn] autorelease];
        
//        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchView)];

        rightBtn.title = @"搜索";
        self.navigationItem.rightBarButtonItem =rightBtn;
    }
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showSearchView;
{
    SearchViewController *searchVC = [[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil] autorelease];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    searchVC.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:searchVC animated:NO];
}

-(void)dealloc
{
    [super dealloc];
}

@end
