//
//  HuiGuangViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "HuiGuangViewController.h"
#import "HuiGuangModel.h"
#import "HuiGuangCell.h"

@interface HuiGuangViewController ()

@end

@implementation HuiGuangViewController

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
    
    self.title = @"惠逛模式";
    
    NSMutableArray *list = [NSMutableArray array];
    HuiGuangModel *model1 = [[HuiGuangModel alloc]init];
    model1.imageIconURL = [[NSBundle mainBundle] pathForResource:@"@2x" ofType:@"png"];
    model1.imageURL = [[NSBundle mainBundle] pathForResource:@"@2x" ofType:@"png"];
    model1.title = @"原价499，现价99，仅限一天。";
    NSDictionary *dict1 = @{@"name":@"蜡笔",@"comment":@"1111111111111"};
    model1.commentList = @[dict1];
    model1.commentCount = 1;
    [list addObject:model1];
     
     
    self.itemList = list;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    HuiGuangCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HuiGuangCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    [_labPosition release];
    [super dealloc];
}
- (IBAction)btnMapAction:(UIButton *)sender {
}
@end
