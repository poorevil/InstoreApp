//
//  BaseViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-27.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"
#import "MainViewController.h"
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
        
        UIView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tmp1"]];
        icon.frame = CGRectMake(0, 0, 40, 40);
        UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        [iconView addSubview:icon];
        
        UIBarButtonItem *iconItem = [[UIBarButtonItem alloc] initWithCustomView:iconView];
        NSArray *items = [NSArray arrayWithObjects:iconItem, nil];
        self.navigationItem.leftBarButtonItems = items;
        self.navigationItem.leftItemsSupplementBackButton = YES;
    }else{
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f
                                                                                 green:40.0f/255.0f
                                                                                  blue:53.0f/255.0f
                                                                                 alpha:1]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
        rightBtn.title = @"搜索";
        self.navigationItem.rightBarButtonItem =rightBtn;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)search
{
    
}

@end
