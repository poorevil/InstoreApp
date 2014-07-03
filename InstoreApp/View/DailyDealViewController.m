//
//  DailyDealViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-1.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DailyDealViewController.h"
#import "DailyDealViewCell.h"
#import "DailyDealModel.h"
#import "WebViewController.h"

#import "GroupBuyDetailViewController.h"
#import "CouponDetailViewController.h"


@interface DailyDealViewController ()<DailyDealInterfaceDelegate>

@end

@implementation DailyDealViewController

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
    
    self.title = @"每日优惠";
    
    self.itemList = [NSMutableArray array];
    
    self.dailyDealInterface = [[DailyDealInterface alloc]init];
    _dailyDealInterface.delegate = self;
    [_dailyDealInterface getDailyDealByPage:self.currentPage amount:20];
    
    
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    DailyDealViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DailyDealViewCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
//    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    DailyDealModel *dailyDealModel = [self.itemList objectAtIndex:indexPath.row];
    cell.title.text = dailyDealModel.title;
    cell.shortTitle.text = dailyDealModel.shortTitle;
    cell.imgView.imageURL = [NSURL URLWithString:dailyDealModel.image];
    cell.summary.text = dailyDealModel.summary;
    cell.focusCount.text = [NSString stringWithFormat:@"%d",dailyDealModel.fousCount];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DailyDealModel *dailyDealModel = [self.itemList objectAtIndex:indexPath.row];
    int itemType = dailyDealModel.itemType;
    int promotionType = dailyDealModel.promotionType;
    switch (itemType) {
        case 1:
        {
            //优惠
            switch (promotionType) {
                case 1:
                {
                    //优惠活动
                    WebViewController *webVC = [[WebViewController alloc]init];
                    webVC.hidesBottomBarWhenPushed = YES;
                    webVC.urlStr = dailyDealModel.url;
                    webVC.titleStr = dailyDealModel.title;
                    [self.navigationController pushViewController:webVC animated:YES];
                    [webVC release];
                }
                    break;
                case 2:
                {
                    //优惠券
                    CouponDetailViewController *coupnDVC = [[CouponDetailViewController alloc]init];
                    coupnDVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:coupnDVC animated:YES];
                    [coupnDVC release];
                }
                    break;
                case 3:
                {
                    //团购
                    GroupBuyDetailViewController *groupBuyDVC = [[GroupBuyDetailViewController alloc]init];
                    groupBuyDVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:groupBuyDVC animated:YES];
                    [groupBuyDVC release];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            //商户
        }
            break;
        case 3:
        {
            //商品
        }
            break;
        case 4:
        {
            //网页
            WebViewController *webVC = [[WebViewController alloc]init];
            webVC.hidesBottomBarWhenPushed = YES;
            webVC.urlStr = dailyDealModel.url;
            webVC.titleStr = dailyDealModel.title;
            [self.navigationController pushViewController:webVC animated:YES];
            [webVC release];
        }
            break;
        default:
            break;
    }
}
#pragma mark - DailyDealInterfaceDelegate
-(void)getDailyDealDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    [self.itemList addObjectsFromArray:itemList];
    self.totalAmount = totalCount;
    self.currentPage = currentPage;
    self.currentPage++;
    
    [self.myTableView reloadData];
}
-(void)getDailyDealDidFailed:(NSString *)errorMsg{
    NSLog(@"%s:%@",__FUNCTION__,errorMsg);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    self.itemList = nil;
    [super dealloc];
}
@end
