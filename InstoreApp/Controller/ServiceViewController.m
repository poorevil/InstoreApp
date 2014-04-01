//
//  ServiceViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceViewCell.h"

@interface ServiceViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mtableView;
@end

@implementation ServiceViewController

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
    
    self.title = @"服务";
    
    self.mtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
                                                                self.view.bounds.size.height)];
    self.mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mtableView.allowsSelection = NO;
    self.mtableView.delegate = self;
    self.mtableView.dataSource = self;
    
    [self.view addSubview:self.mtableView];
    
    UIView *tableViewFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                           self.view.bounds.size.width,
                                                                           100)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                               self.view.bounds.size.width, 100)];
    label.text = @"更多精彩应用，敬请期待";
    label.textAlignment = NSTextAlignmentCenter;
    [tableViewFooterView addSubview:label];
    self.mtableView.tableFooterView = tableViewFooterView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    return  cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"本地生活";
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}


@end
