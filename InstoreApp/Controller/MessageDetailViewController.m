//
//  MessageDetailViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "NSDate+DynamicDateString.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

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
    
    self.labTitle.text = self.messageModel.title;
    self.labDate.text = [self.messageModel.createDate toDateString];
    self.textViewSummary.text = self.messageModel.summary;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.messageModel = nil;
    [_labTitle release];
    [_labDate release];
    [_textViewSummary release];
    [super dealloc];
}
@end
