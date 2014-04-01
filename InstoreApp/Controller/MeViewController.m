//
//  MeViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MeViewController.h"
#import "MeHeaderView.h"

@interface MeViewController ()

@property (nonatomic,strong) MeHeaderView *headerView;

@end

@implementation MeViewController

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
    
    self.title = @"我的信息";
    
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"MeHeaderView"
                                                    owner:self options:nil] objectAtIndex:0];
    self.mtableView.tableHeaderView = self.headerView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 4;
        case 1:
            return 2;
            
        case 2:
            return 1;
            
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
    }
    UISwitch *switchButton1;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我的优惠劵";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.textLabel.text = @"我关注的商家";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 2:
                    cell.textLabel.text = @"消息中心";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 3:
                    cell.textLabel.text = @"消费记录";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"允许推送消息";
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    switchButton1 = [[UISwitch alloc] init];
                    switchButton1.frame = CGRectMake(tableView.frame.size.width - switchButton1.frame.size.width - 10, (cell.frame.size.height - switchButton1.frame.size.height)/2, switchButton1.frame.size.width, switchButton1.frame.size.height);
                    [switchButton1 setOn:YES];
//                    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                    [cell addSubview:switchButton1];
                    break;
                case 1:
                    cell.textLabel.text = @"允许获取地理位置";
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    UISwitch *switchButton = [[UISwitch alloc] init];
                    switchButton.frame = CGRectMake(tableView.frame.size.width - switchButton.frame.size.width - 10, (cell.frame.size.height - switchButton.frame.size.height)/2, switchButton1.frame.size.width, switchButton1.frame.size.height);
                    [switchButton setOn:YES];
                    //                    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                    [cell addSubview:switchButton];
                    break;
            }

            break;
        
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"更换绑定手机";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
            
            break;
            
        default:
            break;
    }
    
    
    return  cell;
}


#pragma mark - UITableViewDelegate



@end
