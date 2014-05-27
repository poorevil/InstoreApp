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

#import "ShopViewController.h"


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
    
    self.title = @"我的信息";
    
    [self initHeaderView];
    
    self.userInfoInterface = [[[UserInfoInterface alloc] init] autorelease];
    self.userInfoInterface.delegate = self;
    [self.userInfoInterface getUserInfo];
    
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
            return 2;
        case 1:
            return 1;
        case 2:
            return 1;
        case 3:
            return 1;
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
    }
    UISwitch *switchButton1;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我的优惠劵";
                    cell.detailTextLabel.text=@"管理我的优惠劵";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.textLabel.text = @"消息中心";
                    cell.detailTextLabel.text=@"查看管理收到的消息";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
//                case 2:
//                    cell.textLabel.text = @"消费记录";
//                    cell.detailTextLabel.text=@"查看历史消费记录";
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我关注的商家";
                    cell.detailTextLabel.text=@"查看管理关注的商家";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
//                case 1:
//                    cell.textLabel.text = @"我关注的商品";
//                    cell.detailTextLabel.text=@"查看管理关注的商品";
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                    break;
//                case 1:
//                    cell.textLabel.text = @"我关注的优惠";
//                    cell.detailTextLabel.text=@"查看管理关注的优惠劵";
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                    break;
//                case 2:
//                    cell.textLabel.text = @"消费记录";
//                    cell.detailTextLabel.text=@"";
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                    break;
            }
            break;
            
        case 2:
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
            }

            break;
        
        case 3:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"更换绑定手机";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
            }
            
            break;
        case 4:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"绑定会员卡";
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //DownloadCouponsViewController
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:{
                    DownloadCouponsViewController *dcvc = [[[DownloadCouponsViewController alloc] initWithNibName:@"DownloadCouponsViewController" bundle:nil] autorelease];
                    dcvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:dcvc animated:YES];
                    dcvc.hidesBottomBarWhenPushed = NO;
                    break;
                }
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    ShopViewController *shopVC = [[[ShopViewController alloc] initWithNibName:@"ShopViewController" bundle:nil] autorelease];
                    shopVC.isShowLikeOnly = YES;
                    shopVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:shopVC animated:YES];
                    shopVC.hidesBottomBarWhenPushed = NO;

                    break;
                }
                default:
                    break;
            }
            break;
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
