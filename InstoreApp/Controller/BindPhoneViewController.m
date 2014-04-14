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
    
    UIImage *originalImage = [[UIImage imageNamed:@"index-red-btn"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self.bindPhoneBtn setBackgroundImage:originalImage forState:UIControlStateNormal];
    [self.bindPhoneBtn setBackgroundImage:originalImage forState:UIControlStateHighlighted];
    [self.bindPhoneBtn setBackgroundImage:originalImage forState:UIControlStateSelected];
    
    originalImage = [[UIImage imageNamed:@"register-phone-forget"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self.findAccountBtn setBackgroundImage:originalImage forState:UIControlStateNormal];
    [self.findAccountBtn setBackgroundImage:originalImage forState:UIControlStateHighlighted];
    [self.findAccountBtn setBackgroundImage:originalImage forState:UIControlStateSelected];
    
    originalImage = [UIImage imageNamed:@"register-phone-submit"];
    [self.fetchCheckNumBtn setBackgroundImage:originalImage forState:UIControlStateNormal];
    [self.fetchCheckNumBtn setBackgroundImage:originalImage forState:UIControlStateHighlighted];
    [self.fetchCheckNumBtn setBackgroundImage:originalImage forState:UIControlStateSelected];
    
    self.title = @"绑定手机";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
