//
//  AboutViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "AboutViewController.h"
#import "RTLabel.h"
#import <MessageUI/MessageUI.h>

@interface AboutViewController ()<RTLabelDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation AboutViewController

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
    
    self.title = @"关于";
    self.hidesBottomBarWhenPushed = YES;
    
    NSString *thisVerson = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    self.labVerson.text = [NSString stringWithFormat:@"本应用为微之商场APP的演示版本，版本号为V%@",thisVerson];    
    
    RTLabel *labelWebLink = [[RTLabel alloc]initWithFrame:CGRectMake(90, 380, 200, 20)];
    labelWebLink.text = @"<a href='http://www.wise-mall.com'><font color=#3cb3eb>http://www.wise-mall.com</font></a>";
    labelWebLink.font = [UIFont systemFontOfSize:12];
    labelWebLink.delegate = self;
    labelWebLink.userInteractionEnabled = YES;
    labelWebLink.tag = 100;
    [self.view addSubview:labelWebLink];
    [labelWebLink release];
    
    RTLabel *labelMassage = [[RTLabel alloc]initWithFrame:CGRectMake(90, 415, 200, 20)];
    labelMassage.text = @"<a href='Wise-Mall@joyx-inc.com'><font color=#3cb3eb>Wise-Mall@joyx-inc.com</font></a>";
    labelMassage.font = [UIFont systemFontOfSize:12];
    labelMassage.delegate = self;
    labelMassage.userInteractionEnabled = YES;
    labelMassage.tag = 200;
    [self.view addSubview:labelMassage];
    [labelMassage release];
}

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url{
    RTLabel *label = (RTLabel *)rtLabel;
    if (label.tag == 100) {
        [[UIApplication sharedApplication] openURL:url];
    }else{
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
        picker.mailComposeDelegate = self;
        [picker setSubject:@"联系我们"];
        NSArray *toRecipients = @[@"Wise-Mall@joyx-inc.com"];
        [picker setToRecipients:toRecipients];
        
        [self presentViewController:picker animated:YES completion:nil];
        [picker release];
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
//    [self dismissModalViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [_labVerson release];
    [super dealloc];
}
@end
