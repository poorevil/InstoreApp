//
//  MallNewsDetailViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-1.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsDetailViewController.h"

@interface MallNewsDetailViewController ()

@end

@implementation MallNewsDetailViewController

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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URL]];
    [_myWebView loadRequest:request];

//    [self performSelector:@selector(printURL) withObject:nil afterDelay:2];
    
//    [_myWebView reload];
//    [_myWebView stopLoading];
//    [_myWebView goBack];
//    [_myWebView stopLoading];
}
//-(void)printURL{
//    NSLog(@"%s:%@",__FUNCTION__,_myWebView.request.URL.absoluteString);
//}
-(void)viewDidAppear:(BOOL)animated{
//    self.hidesBottomBarWhenPushed = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myWebView release];
    self.URL = nil;
    self.imageUrl = nil;
    
    [super dealloc];
}
@end
