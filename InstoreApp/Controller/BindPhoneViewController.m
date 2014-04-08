//
//  BindPhoneViewController.m
//  InstoreApp
//
//  Created by han chao on 14-4-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BindPhoneViewController.h"

@interface BindPhoneViewController ()

@end

@implementation BindPhoneViewController

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
    [self.phoneNumField becomeFirstResponder];
    
    UIImage *originalImage = [UIImage imageNamed:@"index-red-btn"];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 6, 300);
    UIImage *btnBg = [originalImage resizableImageWithCapInsets:insets];
    
    [self.bindPhoneBtn setBackgroundImage:btnBg forState:UIControlStateNormal];
    [self.bindPhoneBtn setBackgroundImage:btnBg forState:UIControlStateHighlighted];
    [self.bindPhoneBtn setBackgroundImage:btnBg forState:UIControlStateSelected];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
