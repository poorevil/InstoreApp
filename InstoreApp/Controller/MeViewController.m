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
#import "MessageViewController.h"
#import "DownloadCouponsViewController.h"
#import "StoreListFocusedViewController.h"

#import "ShopViewController.h"
#import "MyViewCell.h"
#import "MyFocusYouHuiViewController.h"
#import "MyVIPCardViewController.h"
#import "BankCardViewController.h"

#import "SetStoreFocusRecommend.h"

#import "WebViewController.h"
#import "MyDownloadCouponViewController.h"
#import "BindPhoneViewController.h"
#import "AboutViewController.h"



@interface MeViewController () <UserInfoInterfaceDelegate>{
//    UISwitch *_switchButton;
}

@property (nonatomic,strong) MeHeaderView *headerView;

@property (nonatomic,strong) UserInfoInterface *userInfoInterface;
@property (nonatomic,strong) UserInfoModel *userInfo;

//接受通知
@property (assign, nonatomic) BOOL recommend;
@property (retain, nonatomic) SetStoreFocusRecommend *setStoreFocusRecommend;
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
//    [self.userInfoInterface getUserInfo];
    
    self.navigationItem.rightBarButtonItem = nil;
    
    
    self.setStoreFocusRecommend = [[[SetStoreFocusRecommend alloc]init]autorelease];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
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
        case 5:
            return 1;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *cell;
//    if (indexPath.section == 4) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"CellRecive"];
//    }else{
//        cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    }
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:@"cell"] autorelease];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.section) {
        case 0:{
            static NSString *CellIdentifier = @"MyViewCell";
            MyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MyViewCell" owner:self options:nil] objectAtIndex:0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textDict = @{@"title": @"消息中心",@"count":@"(10)"};
//            cell.textDict = @{@"title": @"消息中心",@"count":[NSString stringWithFormat:@"(%d)",self.userInfo.]};
            return cell;
        }
            break;
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    //已下载的优惠劵
                    static NSString *CellIdentifier = @"MyViewCell1";
                    MyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyViewCell" owner:self options:nil] objectAtIndex:0];
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                    cell.textDict = @{@"title": @"已下载的优惠券",@"count":[NSString stringWithFormat:@"(%d)",self.userInfo.promotionCount]};
                    return cell;
                }
                    break;
                case 1:
                    cell.textLabel.text = @"收藏的优惠";
//                    cell.detailTextLabel.text = @"";
                    return cell;
                    break;
            }
        }
            break;            
        case 2:{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我关注的商家";
                    return cell;
                    break;
                case 1:
                    cell.textLabel.text = @"我关注的卡惠";
                    cell.detailTextLabel.text=@"银行信用卡优惠";
                    return cell;
                    break;
            }
        }
            break;
        case 3:{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"我的电子会员卡";
                    return cell;
                    break;
                case 1:
                    cell.textLabel.text = @"商场会员指南";
                    return cell;
                    break;
                case 2:
                    cell.textLabel.text = @"绑定手机号";
                    return cell;
                    break;
            }
        }
            break;
        case 4:{
            cell.textLabel.text = @"接收已关注商家的优惠信息";
            cell.accessoryType = UITableViewCellAccessoryNone;
            UISwitch *_switchButton = [[UISwitch alloc] init];
            _switchButton.frame = CGRectMake(tableView.frame.size.width - _switchButton.frame.size.width - 10, (cell.frame.size.height - _switchButton.frame.size.height)/2, _switchButton.frame.size.width, _switchButton.frame.size.height);
            [_switchButton setOn:_recommend];
            [_switchButton addTarget:self action:@selector(switchButtonChangeAchtion:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:_switchButton];
            [_switchButton release];
    
            return cell;
        }
            break;
        case 5:
            cell.textLabel.text = @"关于";
            return cell;
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
            MessageViewController *vc = [[MessageViewController alloc]initWithNibName:@"MessageViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:{
                    //已下载的优惠券
                    MyDownloadCouponViewController *vc = [[MyDownloadCouponViewController alloc]initWithNibName:@"MyDownloadCouponViewController" bundle:nil];
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
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
                    BankCardViewController *bankCardVC = [[BankCardViewController alloc]initWithNibName:@"BankCardViewController" bundle:nil];
                    bankCardVC.hidesBottomBarWhenPushed = YES;
//                    self.navigationController.title = @"我的卡恵";
                    [self.navigationController pushViewController:bankCardVC animated:YES];
                    self.navigationController.navigationItem.leftBarButtonItem.title = @"";
                    [bankCardVC release];
                }
                    break;
            }
            break;
        case 3:
            switch (indexPath.row) {
                case 0:{
                    //我的电子会员卡
                    MyVIPCardViewController *vc = [[MyVIPCardViewController alloc]initWithNibName:@"MyVIPCardViewController" bundle:nil];
                    vc.code = self.userInfo.clubCard;
                    vc.imageURL = self.userInfo.barCodeUrl;
                    vc.points = self.userInfo.points;
                    
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    [vc  release];
                }
                    break;
                case 1:{
                    //商场会员指南
                    WebViewController *vc = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
                    vc.urlStr = self.userInfo.memberGuideUrl;
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    [vc release];
                }
                    break;
                case 2:{
                    //绑定手机号
                    BindPhoneViewController *vc = [[BindPhoneViewController alloc]initWithNibName:@"BindPhoneViewController" bundle:nil];
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                    self.hidesBottomBarWhenPushed = NO;
                }
                    break;
            }
        case 4:
            //接收已关注商家的优惠信息
            break;
            return;
        case 5:{
            AboutViewController *vc = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            vc.hidesBottomBarWhenPushed = NO;
            [vc release];
        }
            break;
    }
}

#pragma mark - UserInfoInterfaceDelegate <NSObject>
-(void)getUserInfoDidFinished:(UserInfoModel *)userInfo
{
    self.userInfo = userInfo;
    self.headerView.userInfo = self.userInfo;
    self.recommend = userInfo.isStoreFocusRecommend;
//    self.
    
    [self.mtableView reloadData];
}

-(void)getUserInfoDidFailed:(NSString *)errorMessage
{
    DebugLog(@"%@",errorMessage);
}

-(void)setUserInfoDidFinished{
    
}
-(void)setUserInfoDidFailed:(NSString *)errorMessage{
    DebugLog(@"%@",errorMessage);
}

-(void)switchButtonChangeAchtion:(UISwitch *)sender{
    if (!sender.on) {
        [self.setStoreFocusRecommend setStoreFocusRecomend:NO];
        _recommend = NO;
    }else{
        [self.setStoreFocusRecommend setStoreFocusRecomend:YES];
        _recommend = YES;
    }
}
-(void)dealloc
{
    self.mtableView = nil;

    self.headerView = nil;
    self.userInfoInterface.delegate = nil;
    self.userInfoInterface = nil;
    self.userInfo = nil;
    
    self.setStoreFocusRecommend = nil;
    
//    _switchButton = nil;
    
    [super dealloc];
}
@end
