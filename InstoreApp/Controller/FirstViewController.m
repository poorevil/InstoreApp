//
//  FirstViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-14.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

#define DeviceHeight [UIScreen mainScreen].bounds.size.height

@interface FirstViewController ()

@end

@implementation FirstViewController

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

    int h;
    if (DeviceHeight < 500) {
        h = 4;
    }else{
        h = 5;
    }
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320 * i, 0, 320, DeviceHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"firstImage_%d_%d.png",i + 1,h]];
        [self.myScrollView addSubview:imageView];
        [imageView release];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(110 + 320 * 3, DeviceHeight - 40, 100, 30);
    [button setBackgroundImage:[UIImage imageNamed:@"btnFirstVC.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goNextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:button];

    self.myScrollView.contentSize = CGSizeMake(320 * 4, DeviceHeight);
    
}
-(void)goNextAction:(UIButton *)sender{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate initWindow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myScrollView release];
    [super dealloc];
}
@end
