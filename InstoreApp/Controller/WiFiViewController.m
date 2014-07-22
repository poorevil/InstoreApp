//
//  WiFiViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "WiFiViewController.h"

@interface WiFiViewController ()

@end

@implementation WiFiViewController

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
    
    self.title = @"免费WiFi";
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnConnetWiFiAction:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"连接失败！" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
@end
