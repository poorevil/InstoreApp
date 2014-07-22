//
//  BindingVIPCardViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BindingVIPCardViewController.h"

@interface BindingVIPCardViewController ()

@end

@implementation BindingVIPCardViewController

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
    
    self.title = @"绑定会员卡";
    self.hidesBottomBarWhenPushed = YES;
    
    UIImage *image = [UIImage imageNamed:@"downloadCouponSuccess_btn_view.png"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.btnBindingVIPCard setBackgroundImage:image forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_labVIPCardNum release];
    [_labPhoneNum release];
    [_btnBindingVIPCard release];
    [super dealloc];
}
- (IBAction)btnBindingVIPCardAction:(UIButton *)sender {
    //TODO:绑定会员卡接口实现
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"绑定失败" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
