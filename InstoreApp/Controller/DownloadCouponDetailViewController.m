//
//  DownloadCouponDetailViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-19.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DownloadCouponDetailViewController.h"
#import "EGOImageView.h"

#import "DownloadCouponDetailHeaderViewCell.h" //0
#import "CouponDetailWithTitleCell.h" //1、3
#import "MallNewsDetail_threeCell.h"//2

#import "CouponDetailInterface.h"
#import "StoreModel.h"
#import "StoreDetail_RestaurantViewController.h"

#import "NSDate+DynamicDateString.h"

#import "UIViewController+ShareToWeChat.h"


@interface DownloadCouponDetailViewController ()<CouponDetailInterfaceDelegate>

@property (nonatomic,strong) CouponDetailInterface *couponDetailInterface;

@end

@implementation DownloadCouponDetailViewController

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
    
    self.title = @"优惠券详情";
    self.hidesBottomBarWhenPushed = YES;
    
    self.couponDetailInterface = [[[CouponDetailInterface alloc] init] autorelease];
    self.couponDetailInterface.delegate = self;
    [self.couponDetailInterface getCouponDetailByCouponId:self.cid];
    
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShare.frame = CGRectMake(0, 0, 28, 44);
    [btnShare setImage:[UIImage imageNamed:@"share_white.png"] forState:UIControlStateNormal];
    [btnShare setImageEdgeInsets:UIEdgeInsetsMake(13, 5, 13, 5)];
    [btnShare addTarget:self action:@selector(btnShareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btnShare];
    self.navigationItem.rightBarButtonItems = @[barItem];
    [barItem release];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 3;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            return 166;
        }
            break;
        case 1:{
            return 72;
        }
            break;
        case 2:{
            return 50;
        }
            break;
        case 3:{
            //计算内容的size
            CGSize labelFontSize = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 999) lineBreakMode:NSLineBreakByWordWrapping];
            return labelFontSize.height+60;
        }
            break;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"";
    switch (indexPath.section) {
        case 0:{
            CellIdentifier = @"DownloadCouponDetailHeaderViewCell";
        }
            break;
        case 1:{
            CellIdentifier = @"CouponDetailWithTitleCell";
        }
            break;
        case 2:{
            CellIdentifier = @"MallNewsDetail_threeCell";
        }
            break;
        case 3:{
            CellIdentifier = @"CouponDetailWithTitleCell";
        }
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.section) {
        case 0:{
            DownloadCouponDetailHeaderViewCell *cell0 = (DownloadCouponDetailHeaderViewCell *)cell;
            cell0.downloadCouponModel = self.downloadCouponModel;
        }
            break;
        case 1:{
            CouponDetailWithTitleCell *cell1 = (CouponDetailWithTitleCell *)cell;
            cell1.titleLabel.text = @"有效期";
            cell1.iconView.image = [UIImage imageNamed:@"store-icon-clock.png"];
            cell1.detailLabel.text = [NSString stringWithFormat:@"%@ 至 %@",[self.couponModel.startTime toDateString],[self.couponModel.endTime toDateString]];
        }
            break;
        case 2:{
            MallNewsDetail_threeCell *threeCell = (MallNewsDetail_threeCell *)cell;
            threeCell.selectionStyle = UITableViewCellSelectionStyleGray;
            switch (indexPath.row) {
                case 0:
                {
                    threeCell.iconImage.image = [UIImage imageNamed:@"Icon_store.png"];
                    threeCell.labClass.text = @"商户";
                    threeCell.labName.text = self.couponModel.store.title;
                }
                    break;
                case 1:
                {
                    threeCell.iconImage.image = [UIImage imageNamed:@"Icon_address.png"];
                    threeCell.labClass.text = @"地址";
                    threeCell.labName.text = self.couponModel.store.address;
                }
                    break;
                case 2:
                {
                    threeCell.iconImage.image = [UIImage imageNamed:@"Icon_phone.png"];
                    threeCell.labClass.text = @"电话";
                    //                    threeCell.img.hidden = YES;
                    threeCell.labName.textColor = [UIColor colorWithRed:60/255.0 green:179/255.0 blue:235/255.0 alpha:1];
                    threeCell.labName.text = self.couponModel.store.tel;
                }
            }
        }
            break;
        case 3:{
            CouponDetailWithTitleCell *withTitleCell = (CouponDetailWithTitleCell *)cell;
            withTitleCell.titleLabel.text = @"优惠劵详情";
            withTitleCell.iconView.image = [UIImage imageNamed:@"store-icon-feed"];
            withTitleCell.detailLabel.text = self.couponModel.descriptionStr;
            withTitleCell.detailLabel.numberOfLines = 39;
            //计算内容的size
            CGSize labelFontSize = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                               constrainedToSize:CGSizeMake(300, 999)
                                                                   lineBreakMode:NSLineBreakByWordWrapping];
            
            withTitleCell.detailLabel.frame = CGRectMake(withTitleCell.detailLabel.frame.origin.x,
                                                         withTitleCell.detailLabel.frame.origin.y,
                                                         withTitleCell.detailLabel.frame.size.width,
                                                         labelFontSize.height);
            withTitleCell.frame = CGRectMake(0, 0, withTitleCell.frame.size.width, 370);
        }
            break;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:{
                //商户
                StoreDetail_RestaurantViewController *vc = [[StoreDetail_RestaurantViewController alloc]initWithNibName:@"StoreDetail_RestaurantViewController" bundle:nil];
                vc.shopId = self.couponModel.store.sid;
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
            }
                break;
            case 1:{
                //地址
                
            }
                break;
            case 2:{
                //电话
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.couponModel.store.tel]]];
            }
                break;
        }
    }
}


#pragma mark - CouponDetailInterfaceDelegate <NSObject>
-(void)getCouponDetailDidFinished:(CouponModel *)couponModel
{
    self.couponModel = couponModel;
    
    [self.myTableView reloadData];
}
-(void)getCouponDetailDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

-(void)btnShareAction:(UIButton *)sender{
    [self shareToWeChatWithTitle:self.couponModel.title Description:nil LinkURL:[NSString stringWithFormat:@"%@/m/%@/coupon/detail/%d",BASE_INTERFACE_DOMAIN,MALL_CODE,self.couponModel.cid]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    
    self.couponModel = nil;
    self.couponDetailInterface.delegate = nil;
    self.couponDetailInterface = nil;
    self.downloadCouponModel = nil;
    
    [super dealloc];
}
@end
