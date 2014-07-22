//
//  CouponViewController.m
//  InstoreApp
//
//  Created by hanchao on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponViewController.h"


#import "CouponviewInterface.h"
#import "CouponSectionTwoInterface.h"
#import "CouponSearchOrderInterface.h"

#import "CouponView_titleCell.h"
#import "CouponView_focusedCell.h"
#import "CouponView_empty2_Cell.h"

#import "YouhuiCategoryViewController.h"
#import "YouHuiOrderViewController.h"

#import "MyFocusYouHuiViewController.h"  //我收藏的优惠 （团、券、恵）


@interface CouponViewController () <UITableViewDataSource, UITableViewDelegate,
CouponViewInterfaceDelegate, YouhuiCategoryViewControllerDelegate,YouHuiOrderViewControllerDelegate,CouponSectionTwoInterfaceDelegate,CouponSearchOrderInterfaceDelegate>

@property (nonatomic, retain) NSMutableDictionary *itemListDict;//关注的商户的优惠集合
@property (nonatomic, retain) NSDictionary *otherGroupDict;//其他组内容集合

@property (nonatomic, assign) NSInteger focusCount;//用户收藏的优惠数量



@property (nonatomic, retain) CouponViewInterface *couponViewInterface; //收藏接口
@property (retain, nonatomic) CouponSectionTwoInterface *couponSectionTwoInterface;
@property (retain, nonatomic) CouponSearchOrderInterface *couponSearchOrderInterface;

@property (retain, nonatomic) NSMutableArray *itemList;
@property (retain, nonatomic) NSMutableArray *itemList2;
@property (retain, nonatomic) NSMutableArray *itemListAll;
@property (assign, nonatomic) NSInteger currentPageAll;
@property (assign, nonatomic) NSInteger currentPage1;
@property (assign, nonatomic) NSInteger currentPage2;
@property (assign, nonatomic) NSInteger totalCountAll;
@property (assign, nonatomic) NSInteger totalCount1;
@property (assign, nonatomic) NSInteger totalCount2;


@property (retain, nonatomic) NSString *order;


@end

@implementation CouponViewController

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
    
    self.currentPageAll = 1;
    self.currentPage1 = 1;
    self.currentPage2 = 1;
    
    self.title = @"优惠";
    
    self.itemList = [NSMutableArray array];
    self.itemList2 = [NSMutableArray array];
    self.itemListAll = [NSMutableArray array];
    
    
    if (!self.couponSearchOrderInterface) {
        self.couponSearchOrderInterface = [[[CouponSearchOrderInterface alloc]init]autorelease];
        self.couponSearchOrderInterface.delegate = self;
    }


    //关注商户的优惠
    self.couponViewInterface = [[[CouponViewInterface alloc] init] autorelease];
    self.couponViewInterface.delegate = self;
    [self.couponViewInterface getCouponViewListByPage:self.currentPage1 amount:20];
    
    //其他商户的优惠
    self.couponSectionTwoInterface = [[[CouponSectionTwoInterface alloc]init]autorelease];
    self.couponSectionTwoInterface.delegate = self;
    [self.couponSectionTwoInterface getCouponSectionTwoListByPage:self.currentPage2 amount:20];
    
    
    if (self.refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,0.0f - self.mtableView.bounds.size.height,self.mtableView.frame.size.width,self.mtableView.bounds.size.height)];
		view.delegate = self;
		[self.mtableView addSubview:view];
		self.refreshHeaderView = view;
	}
    [self.refreshHeaderView refreshLastUpdatedDate];

}

//从首页过来
-(void)loadCategoryData{
    if (!self.couponSearchOrderInterface) {
        self.couponSearchOrderInterface = [[[CouponSearchOrderInterface alloc]init]autorelease];
        self.couponSearchOrderInterface.delegate = self;
    }
    [self.orderBtn setTitle:self.filterCategory.cName forState:UIControlStateNormal];
    [self.itemListAll removeAllObjects];
    self.currentPageAll = 1;
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPageAll Cid:self.cid Type:self.type Order:self.order];
}
-(void)loadTypeData:(NSInteger)type{
    if (!self.couponSearchOrderInterface) {
        self.couponSearchOrderInterface = [[[CouponSearchOrderInterface alloc]init]autorelease];
        self.couponSearchOrderInterface.delegate = self;
    }
    self.cid = 0;
    [self.itemListAll removeAllObjects];
    self.currentPageAll = 1;
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPageAll Cid:self.cid Type:type Order:self.order];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.typeBtn = nil;
    self.orderBtn = nil;
    self.mtableView = nil;
    self.couponSearchOrderInterface.delegate = nil;
    self.couponSearchOrderInterface = nil;
    self.couponViewInterface.delegate = nil;
    self.couponViewInterface = nil;
    self.couponSectionTwoInterface.delegate = nil;
    self.couponSectionTwoInterface = nil;
    self.itemListDict = nil;
    self.otherGroupDict = nil;
//    self.otherGroupKeysOrder = nil;
    self.filterCategory = nil;
    self.itemList = nil;
    self.itemList2 = nil;
    self.itemListAll = nil;
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource<NSObject>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isOrder1 == YES || self.isOrder2 == YES) {
        return 1;
    }else{
        return 4;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOrder1 == YES || self.isOrder2 == YES) {
        return ceil(self.itemListAll.count /2.0);
    }else{
        switch (section) {
            case 0:
                return 0;
                break;
            case 1:
                return ceil((self.itemList.count +1 ) / 2.0);
                break;
            case 2:
                return 1;
                break;
            case 3:
                return ceil(self.itemList2.count / 2.0);
                break;
            default:
                return 0;
                break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isOrder1 == YES || self.isOrder2 == YES) {
        return 236;
    }else{
        switch (indexPath.section) {
            case 0:
                return 0;
                break;
            case 2:
                return 44;
                break;
            case 1:
                if (indexPath.row == ceil((self.itemList.count +1 ) / 2)) {
                    return 120;
                }else{
                    return 236;
                }
                break;
            case 3:
                return 236;
                break;
            default:
                return 236;
                break;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOrder1 == NO && self.isOrder2 == NO) {
        switch (indexPath.section) {
            case 1:
            {   //收藏店铺的优惠
                if (self.itemList.count % 2 == 0) {
                    //收藏店铺的优惠数量是偶数时
                    if (self.itemList.count < (indexPath.row * 2 + 1)) {
                        //如果是最后一行时，出现一个占整行位置的“添加”cell
                        static NSString *CellIdentifier = @"CouponView_empty2_Cell";
                        CouponView_empty2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (!cell) {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_empty2_Cell" owner:self options:nil] objectAtIndex:0];
                        }
                        return cell;
                    }else{
                        //不是最后一行
                        static NSString *CellIdentifier = @"CouponView_focusedCell";
                        CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (!cell) {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
                        }
                        cell.cm1 = [self.itemList objectAtIndex:indexPath.row * 2];
                        cell.cm2 = [self.itemList objectAtIndex:(indexPath.row * 2 + 1)];
                        return cell;
                    }
                }else{
                    //收藏店铺的优惠数量是奇数时
                    static NSString *CellIdentifier = @"CouponView_focusedCell";
                    CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
                    }
                    cell.cm1 = [self.itemList objectAtIndex:indexPath.row * 2];
                    if (self.itemList.count == indexPath.row * 2 +1) {
                        cell.cm2 = nil;
                    }else{
                        cell.cm2 = [self.itemList objectAtIndex:(indexPath.row * 2 + 1)];
                    }
                    return cell;
                }
            }
                break;
            case 3:
            {
                static NSString *CellIdentifier = @"CouponView_focusedCell";
                CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
                }
                cell.cm1 = [self.itemList2 objectAtIndex:indexPath.row * 2];
                if (self.itemList2.count < indexPath.row * 2 +1) {
                    cell.cm2 = nil;
                }else{
                    cell.cm2 = [self.itemList2 objectAtIndex:(indexPath.row * 2 + 1)];
                }
                return cell;
            }
                break;
            case 0:
            {
                static NSString *CellIdentifier = @"CouponView_titleCell";
                CouponView_titleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_titleCell"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
                }
                cell.titleLabel.text = @"收藏商品的优惠";
                return cell;
            }
                break;
            case 2:
            {
                static NSString *CellIdentifier = @"CouponView_titleCell";
                CouponView_titleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_titleCell"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
                }
                cell.titleLabel.text = @"可能感兴趣的优惠";
                return cell;
            }
                break;
        }
    }
    static NSString *CellIdentifier = @"CouponView_focusedCell";
    CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.cm1 = [self.itemListAll objectAtIndex:indexPath.row * 2];
    if (self.itemListAll.count < indexPath.row * 2 +1) {
        cell.cm2 = nil;
    }else{
        cell.cm2 = [self.itemListAll objectAtIndex:(indexPath.row * 2 + 1)];
    }
    return cell;
}


#pragma mark - CouponViewInterfaceDelegate <NSObject>
- (void)getCouponViewListDidFinished:(NSArray *)resultArray
                          focusCount:(NSInteger)focusCount
                          totalCount:(NSInteger)totalCount
                         currentPage:(NSInteger)currentPage
{
    self.totalCount1 = totalCount;
    self.currentPage1 = currentPage;
    self.currentPage1++;
    
    [self.itemList addObjectsFromArray:resultArray];
    
    [self.mtableView reloadData];
}

- (void)getCouponViewListDidFailed:(NSString *)errorMsg
{
    NSLog(@"%@",errorMsg);
}

#pragma mark - CouponSectionTwoInterfaceDelegate
- (void)getCouponSectionTwoListDidFinished:(NSArray *)resultArray focusCount:(NSInteger)focusCount totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    self.totalCount2 = totalCount;
    self.currentPage2 = currentPage;
    self.currentPage2++;
    
    [self.itemList2 addObjectsFromArray:resultArray];
    [self.mtableView reloadData];
    [self.favorBtn setTitle:[NSString stringWithFormat:@"已收藏%d",focusCount] forState:UIControlStateNormal];
}
- (void)getCouponSectionTwoListDidFailed:(NSString *)errorMsg{
   NSLog(@"%@",errorMsg);
}
    
#pragma mark - CouponSearchOrderInterfaceDelegate
-(void)couponSearchOrderDidFinished:(NSArray*)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage{
    
    [self.itemListAll addObjectsFromArray:result];
    self.totalCountAll = totalAmount;
    self.currentPageAll = currentPage;
    self.currentPageAll++;
    
    [self.mtableView reloadData];
    [self.mtableView scrollRectToVisible:CGRectMake(0, 0, 320, 1) animated:YES];
}
-(void)couponSearchOrderDidFailed:(NSString*)errorMessage{
    NSLog(@"%s:%@",__FUNCTION__,errorMessage);
}


//排序：全部、人气、收藏、结束时间
- (IBAction)btnOrderAction:(UIButton *)sender {
    YouHuiOrderViewController *vc= [[YouHuiOrderViewController alloc]init];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
    [vc release];
    
    self.isOrder1 = YES;
}
#pragma mark - YouHuiOrderViewControllerDelegate
-(void)youHuiOrderViewControllerDidSelected:(NSUInteger)index{
    //@[@"默认排序",@"人气优先",@"收藏数量",@"结束时间"];
    switch (index) {
        case 0: {
            self.order = @"";
            [self.typeBtn setTitle:@"默认排序" forState:UIControlStateNormal];
            self.isOrder1 = NO;
        }
            break;
        case 1:{
            self.order = @"hot";
            [self.typeBtn setTitle:@"人气优先" forState:UIControlStateNormal];
        }
            break;
        case 2:{
            self.order = @"collect";
            [self.typeBtn setTitle:@"收藏数量" forState:UIControlStateNormal];
        }
            break;
        case 3:{
            self.order = @"latest";
            [self.typeBtn setTitle:@"结束时间" forState:UIControlStateNormal];
        }
        default:
            break;
    }
    
    //@[@"",@"人气",@"收藏",@"结束时间"];
    
    [self.itemListAll removeAllObjects];
    self.currentPageAll = 1;
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPageAll Cid:self.cid Type:self.type Order:self.order];
}

//分类-全部、潮流女装、男人帮。。。。。。
- (IBAction)btnCategoryAction:(UIButton *)sender {
    YouhuiCategoryViewController *cateVC = [[YouhuiCategoryViewController alloc] initWithCategoryModel:self.filterCategory];
    cateVC.delegate = self;
    cateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cateVC animated:YES];
    cateVC.hidesBottomBarWhenPushed = NO;
    [cateVC release];
    
    self.isOrder2 = YES;
}
#pragma mark - YouhuiCategoryViewControllerDelegate
-(void)categoryDidSelected:(CategoryModel *)categoryModel
{
    self.filterCategory = categoryModel;
    if ([self.filterCategory.cName isEqualToString:@"全部分类"]) {
        [self.orderBtn setTitle:@"全部分类" forState:UIControlStateNormal];
        self.isOrder2 = NO;
    }else{
        [self.orderBtn setTitle:[NSString stringWithFormat:@"%@",categoryModel.cName]
                       forState:UIControlStateNormal];
    }
    self.cid = categoryModel.cid;
    self.currentPageAll = 1;
    [self.itemListAll removeAllObjects];
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPageAll Cid:self.cid Type:self.type Order:self.order];
}

//我的收藏
- (IBAction)btnMyFocusYouHuiAction:(UIButton *)sender {
    MyFocusYouHuiViewController *vc = [[MyFocusYouHuiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark - Data Source Loading / Reloading Methods
-(void)refreshDate
{
    if (self.isOrder1 == YES || self.isOrder2 == YES) {
        self.currentPageAll = 1;
        [self.itemListAll removeAllObjects];
        [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPageAll Cid:self.cid Type:self.type Order:self.order];
    }else{
        self.currentPage1 = 1;
        self.currentPage2 = 1;
        [self.itemList removeAllObjects];
        [self.itemList2 removeAllObjects];
        [self.couponViewInterface getCouponViewListByPage:self.currentPageAll amount:20];
        [self.couponSectionTwoInterface getCouponSectionTwoListByPage:self.currentPage2 amount:20];
    }
//
}
- (void)reloadTableViewDataSource{
	_reloading = YES;
    [self refreshDate];
}

- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mtableView];
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


@end
