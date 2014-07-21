//
//  DownloadCouponSuccessViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-21.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DownloadCouponSuccessViewController.h"
#import "NSDate+DynamicDateString.h"
#import "MyDownloadCouponViewController.h"

@interface DownloadCouponSuccessViewController ()

@end

@implementation DownloadCouponSuccessViewController

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
    
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"优惠券下载";
    self.imageIconSubview.layer.borderColor = [UIColor colorWithRed:214/255.0 green:191/255.0 blue:124/255.0 alpha:1].CGColor;
    self.imageIconSubview.layer.borderWidth = 0.5;
    
    self.labTitle.text = self.titleStr;
    self.imageIcon.imageURL = [NSURL URLWithString:self.imageURL];
    self.labDate.text = [NSString stringWithFormat:@"有效期:%@ ~ %@",[self.couponDownloadModel.startTime toDateString],[self.couponDownloadModel.endTime toDateString]];
    self.labNum.text = self.couponDownloadModel.couponCode;
    self.labInstruction.text = [NSString stringWithFormat:@"1、一张代金券只能使用一次，不兑现，不找零，现金券金额不开具在发票内。\n2、现金券需在有效期内使用，过期作废。"];
    
    UIImage *image = [UIImage imageNamed:@"downloadCouponSuccess_btn_view.png"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.btnViewCoupon setBackgroundImage:image forState:UIControlStateNormal];
    
    [self.btnViewCoupon addTarget:self action:@selector(btnViewCouponAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)btnViewCouponAction:(UIButton *)sender{
    MyDownloadCouponViewController *vc = [[MyDownloadCouponViewController alloc]initWithNibName:@"MyDownloadCouponViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_imageIconSubview release];
    [_imageIcon release];
    [_labTitle release];
    [_labDate release];
    [_labNum release];
    [_labInstruction release];
    
    self.titleStr = nil;
    self.imageURL = nil;
    self.couponDownloadModel = nil;
    [_btnViewCoupon release];
    [super dealloc];
}
@end
