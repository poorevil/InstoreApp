//
//  WebViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController

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
    
    self.title = self.titleStr;
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    _hud.delegate = self;
    _hud.labelText = @"Loading";
    [self.view addSubview:self.hud];
    [_hud show:YES];
//    [_hud showWhileExecuting:@selector(oneTask) onTarget:self withObject:nil animated:YES];
    
//    NSURL *URL = [NSURL URLWithString:self.urlStr];
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
//    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//    [connection start];
    
    NSURL *URL = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:URL];
    [self.myWebView loadRequest:request];
    
    
}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    
//}
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    
//}
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    NSLog(@"%s:%@",__FUNCTION__,error);
//}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    sleep(0.5);
    [self.hud removeFromSuperview];
}
- (void)hudWasHidden:(MBProgressHUD *)hud{
    [self.hud removeFromSuperview];
}

-(void)dealloc{
    self.urlStr = nil;
    self.hud = nil;
    self.hud.delegate = nil;
    self.titleStr = nil;
    
    [_myWebView release];
    [super dealloc];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)webViewGoBackAction:(UIButton *)sender {
    if (_myWebView.canGoBack) {
        [_myWebView goBack];
    }
}

- (IBAction)wenViewGoNextAction:(UIButton *)sender {
    if (_myWebView.canGoForward) {
        [_myWebView goForward];
    }
}

- (IBAction)webViewReloadAction:(UIButton *)sender {
    [_myWebView reload];
}
@end