//
//  DailyDealViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-1.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DailyDealViewController.h"
#import "DailyDealViewCell.h"
#import "CouponModel.h"
#import "WebViewController.h"

#import "GroupBuyDetailViewController.h"
#import "CouponDetailViewController.h"
#import "MallNewsDetailViewController.h"


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
    self.hidesBottomBarWhenPushed = YES;
    self.itemList = [NSMutableArray array];
    self.currentPage = 1;
    self.everyPageCount = 10;
    
    self.dailyDealInterface = [[[DailyDealInterface alloc]init]autorelease];
    _dailyDealInterface.delegate = self;
    [_dailyDealInterface getDailyDealByPage:self.currentPage amount:self.everyPageCount];

    self.navigationItem.rightBarButtonItem = nil;
    
    if (self.refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - self.myTableView.bounds.size.height,self.myTableView.frame.size.width,self.myTableView.bounds.size.height)];
		view.delegate = self;
		[self.myTableView addSubview:view];
		self.refreshHeaderView = view;
	}
    [self.refreshHeaderView refreshLastUpdatedDate];
    
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
    CouponModel *couponModel = [self.itemList objectAtIndex:indexPath.row];
    cell.title.text = couponModel.title;
    cell.shortTitle.text = couponModel.shortTitle;
    cell.imgView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/120*120.png",couponModel.imageUrl]];
    cell.summary.text = couponModel.summary;
    cell.focusCount.text = [NSString stringWithFormat:@"%d",couponModel.focusCount];
    
    if (indexPath.row == self.itemList.count -1) {
        if (self.currentPage * self.everyPageCount < self.itemList.count) {
            self.currentPage++;
            [self loadMoreData];
        }
        
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponModel *couponModel = [self.itemList objectAtIndex:indexPath.row];
    int itemType = couponModel.itemType;
    int promotionType = couponModel.promotionType;
    switch (itemType) {
        case 1:
        {
            //优惠
            switch (promotionType) {
                case 1:
                {
                    //优惠活动
                    MallNewsDetailViewController *vc = [[MallNewsDetailViewController alloc]initWithNibName:@"MallNewsDetailViewController" bundle:nil];
                    vc.couponModel = couponModel;
                    vc.couponModel.cid = couponModel.itemId;
                    [self.navigationController pushViewController:vc animated:YES];
                    [vc release];
                }
                    break;
                case 2:
                {
                    //优惠券
                    CouponDetailViewController *coupnDVC = [[CouponDetailViewController alloc]init];
                    coupnDVC.couponModel = couponModel;
                    coupnDVC.couponModel.cid = couponModel.itemId;
                    coupnDVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:coupnDVC animated:YES];
                    [coupnDVC release];
                }
                    break;
                case 3:
                {
                    //团购
                    GroupBuyDetailViewController *groupBuyDVC = [[GroupBuyDetailViewController alloc]init];
                    groupBuyDVC.couponModel = couponModel;
                    groupBuyDVC.couponModel.cid = couponModel.itemId;
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
            webVC.urlStr = couponModel.link;
            webVC.titleStr = @"优惠详情";
            [self.navigationController pushViewController:webVC animated:YES];
            [webVC release];
        }
            break;
        default:
            break;
    }
}
-(void)loadMoreData{
    [_dailyDealInterface getDailyDealByPage:self.currentPage amount:self.everyPageCount];
}

#pragma mark - Data Source Loading / Reloading Methods
-(void)refreshDate{
    self.currentPage = 1;
    [self.itemList removeAllObjects];
    [_dailyDealInterface getDailyDealByPage:self.currentPage amount:20];
}
- (void)reloadTableViewDataSource{
	_reloading = YES;
    [self refreshDate];
}

- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}

#pragma mark - DailyDealInterfaceDelegate
-(void)getDailyDealDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    [self.itemList addObjectsFromArray:itemList];
    self.totalAmount = totalCount;
    
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
