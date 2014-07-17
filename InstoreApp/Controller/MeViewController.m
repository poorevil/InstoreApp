//
//  MeViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MeViewController.h"
#import "MeHeaderView.h"

#import "UserInfoInterface.h"
#import "UserInfoModel.h"

#import "DownloadCouponsViewController.h"
#import "StoreListFocusedViewController.h"

#import "ShopViewController.h"
#import "MyViewCell.h"
#import "MyFocusYouHuiViewController.h"

@interface MeViewController () <UserInfoInterfaceDelegate>

@property (nonatomic,strong) MeHeaderView *headerView;

@property (nonatomic,strong) UserInfoInterface *userInfoInterface;
@property (nonatomic,strong) UserInfoModel *userInfo;
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
    
    self.title = @"我的";
    
    [self initHeaderView];
    
    self.userInfoInterface = [[[UserInfoInterface alloc] init] autorelease];
    self.userInfoInterface.delegate = self;
    [self.userInfoInterface getUserInfo];
    
    self.navigationItem.rightBarButtonItem = nil;
    
}

-(void)initHeaderView
{
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
            return 1;
        case 1:
            return 2;
        case 2:
            return 2;
        case 3:
            return 3;
        case 4:
            return 1;
            
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"] autorelease];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    UISwitch *switchButton1;
    switch (indexPath.section) {
        case 0:{
            static NSString *CellIdentifier = @"MyViewCell";
            MyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MyViewCell" owner:self options:nil] objectAtIndex:0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textDict = @{@"title": @"消息中心",@"count":@"（5）"};
            return cell;
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    //已下载的优惠劵
                    static NSString *CellIdentifier = @"MyViewCell";
                    MyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyViewCell" owner:self options:nil] objectAtIndex:0];
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                    cell.textDict = @{@"title": @"已下载的优惠券",@"count":@"（5）"};
                    return cell;
                }
                    break;
                case 1:
                    cell.textLabel.text = @"收藏的优惠";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
            break;
            
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我关注的商家";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.textLabel.text = @"我关注的卡惠";
                    cell.detailTextLabel.text=@"银行信用卡优惠";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我的电子会员卡";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.textLabel.text = @"商场会员指南";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 2:
                    cell.textLabel.text = @"绑定手机号";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
            break;
        case 4:
            cell.textLabel.text = @"接收已关注商家的优惠信息";
            cell.accessoryType = UITableViewCellAccessoryNone;
            switchButton1 = [[UISwitch alloc] init];
            switchButton1.frame = CGRectMake(tableView.frame.size.width - switchButton1.frame.size.width - 10, (cell.frame.size.height - switchButton1.frame.size.height)/2, switchButton1.frame.size.width, switchButton1.frame.size.height);
            [switchButton1 setOn:YES];
            [cell.contentView addSubview:switchButton1];
            [switchButton1 release];
    }
    
    return  cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:{
            //消息中心
            
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    //已下载的优惠券
                    
                }
                    break;
                case 1:{
                    //收藏的优惠
                    MyFocusYouHuiViewController *vc = [[MyFocusYouHuiViewController alloc]init];
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                }
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:{
                    //我关注的商家
                    StoreListFocusedViewController *slfVC = [[[StoreListFocusedViewController alloc] initWithNibName:@"StoreListFocusedViewController" bundle:nil] autorelease];
                    slfVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:slfVC animated:YES];
                    slfVC.hidesBottomBarWhenPushed = NO;
                    break;
                }   
                case 1:{
                    //我关注的卡恵
                    
                }
                    break;
            }
        case 3:
            switch (indexPath.row) {
                case 0:{
                    //我的电子会员卡
                    
                }
                    break;
                case 1:{
                    //商场会员指南
                    
                }
                case 2:{
                    //绑定手机号
                    
                }
            }
            case 4:
            //接收已关注商家的优惠信息
            return;
    }
}

#pragma mark - UserInfoInterfaceDelegate <NSObject>
-(void)getUserInfoDidFinished:(UserInfoModel *)userInfo
{
    self.userInfo = userInfo;
    self.headerView.userInfo = self.userInfo;
}

-(void)getUserInfoDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

-(void)dealloc
{
    self.mtableView = nil;

    self.headerView = nil;
    self.userInfoInterface.delegate = nil;
    self.userInfoInterface = nil;
    self.userInfo = nil;
    
    [super dealloc];
}
@end
