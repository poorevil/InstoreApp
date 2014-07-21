//
//  ShopViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopViewCell.h"
#import "ShopDetailViewController.h"
#import "FloorModel.h"
#import "FloorSelectViewController.h"
#import "CategoryModel.h"
#import "YouhuiCategoryViewController.h"
#import "MainViewController.h"
#import "EGORefreshTableHeaderView.h"

#import "StoreInterface.h"
#import "StoreModel.h"

@interface ShopViewController () <FloorSelectViewControllerDelegate,YouhuiCategoryViewControllerDelegate,StoreInterfaceDelegate,EGORefreshTableHeaderDelegate>

@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件
@property (nonatomic,strong) FloorModel *filterFloorModel;//楼层筛选

@property (nonatomic,strong) StoreInterface *storeInterface;
@property (nonatomic,strong) NSMutableArray *storeList;
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,strong) EGORefreshTableHeaderView *refreshHeaderView;

//  Reloading var should really be your tableviews datasource
//  Putting it here for demo purposes
@property (nonatomic,assign) BOOL reloading;


@end

@implementation ShopViewController

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
    

    
    
    self.mtable = [[[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                self.likeBtn.superview.frame.size.height + self.likeBtn.superview.frame.origin.y,
                                                                self.view.frame.size.width,
                                                                self.view.frame.size.height  - self.likeBtn.superview.frame.origin.y-8)] autorelease];
    self.mtable.delegate = self;
    self.mtable.dataSource = self;
    [self.view addSubview:self.mtable];

    self.mtable.tableHeaderView = nil;
    
    self.storeList = [NSMutableArray array];
    self.title = self.isShowLikeOnly?@"我关注的商家":@"商户";
    
    self.likeBtn.hidden = self.isShowLikeOnly;
    
    [self.floorBtn addTarget:self action:@selector(floorBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.cateBtn addTarget:self action:@selector(categoryBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.likeBtn addTarget:self action:@selector(likeBtnAction:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self refreshDate];
    
    if (self.refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                                      0.0f - self.mtable.bounds.size.height,
                                                                                                      self.view.frame.size.width,
                                                                                                      self.mtable.bounds.size.height)];
		view.delegate = self;
		[self.mtable addSubview:view];
		self.refreshHeaderView = view;
	}
	
	//  update the last update date
	[self.refreshHeaderView refreshLastUpdatedDate];
    

}

- (void)ClickShare
{
    NSLog(@"分享");
}
-(void)refreshDate
{
    [self.storeList removeAllObjects];
    [self.mtable reloadData];
    self.currentPage = 1;
    
    [self loadNextPage];
}

-(void)loadNextPage
{
    self.storeInterface = [[[StoreInterface alloc] init] autorelease];
    self.storeInterface.delegate = self;
    [self.storeInterface getStoreListByFloor:[NSString stringWithFormat:@"%d",self.filterFloorModel.fid]
                                         cid:self.filterCategory.cid
                                       order:nil
                                      isLike:self.isShowLikeOnly?1:0
                                      amount:20
                                        page:self.currentPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.storeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.storeModel = [self.storeList objectAtIndex:indexPath.row];
    
    return  cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShopDetailViewController *shopDetailVC = [[[ShopDetailViewController alloc]
                                              initWithNibName:@"ShopDetailViewController"
                                              bundle:nil] autorelease];
    shopDetailVC.shopId = [[self.storeList objectAtIndex:indexPath.row] sid];
    shopDetailVC.title = [[self.storeList objectAtIndex:indexPath.row] title];
    shopDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopDetailVC animated:YES];
    shopDetailVC.hidesBottomBarWhenPushed = NO;
}

#pragma mark - private method
-(void)floorBtnAction:(id)sender
{
    FloorSelectViewController *floorVC = [[FloorSelectViewController alloc] initWithFloorModel:self.filterFloorModel];
    floorVC.delegate = self;
    floorVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:floorVC animated:YES];
    floorVC.hidesBottomBarWhenPushed = NO;
}

-(void)categoryBtnAction:(id)sender
{
    YouhuiCategoryViewController *cateVC = [[YouhuiCategoryViewController alloc] initWithCategoryModel:self.filterCategory];
    cateVC.delegate = self;
    cateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cateVC animated:YES];
    cateVC.hidesBottomBarWhenPushed = NO;
}

-(void)likeBtnAction:(id)sender
{
    ShopViewController *likeOnlyVC = [[[ShopViewController alloc] initWithNibName:@"ShopViewController"
                                                                              bundle:nil] autorelease];
    likeOnlyVC.isShowLikeOnly = YES;
    likeOnlyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:likeOnlyVC animated:YES];
    likeOnlyVC.hidesBottomBarWhenPushed = NO;
}

#pragma mark - FloorSelectViewControllerDelegate
-(void)floorSelectDidFinished:(FloorModel *) floorModel
{
    self.filterFloorModel = floorModel;
    
    if (self.filterFloorModel) {
        [self.floorBtn setTitle:[NSString stringWithFormat:@"%@ ",self.filterFloorModel.fName]
                       forState:UIControlStateNormal];
    }else{
        [self.floorBtn setTitle:@"楼层 " forState:UIControlStateNormal];
    }
    
    [self refreshDate];
}

#pragma mark - YouhuiCategoryViewControllerDelegate
-(void)categoryDidSelected:(CategoryModel *)categoryModel
{
    self.filterCategory = categoryModel;
    if (self.filterCategory) {
        [self.cateBtn setTitle:[NSString stringWithFormat:@"%@ ",categoryModel.cName]
                      forState:UIControlStateNormal];
    }else{
        [self.cateBtn setTitle:@"分类 " forState:UIControlStateNormal];
    }
    
    [self refreshDate];
}

#pragma mark - StoreInterfaceDelegate <NSObject>

-(void)getStoreListDidFinished:(NSArray *)resultList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage
{
    [self.storeList addObjectsFromArray:resultList];
    [self.mtable reloadData];
}

-(void)getStoreListDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{
	_reloading = YES;
    [self refreshDate];
}

- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mtable];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
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

-(void)dealloc
{
    self.mtable = nil;
    self.floorBtn = nil;
    self.cateBtn = nil;
    self.sortBtn = nil;
    self.likeBtn = nil;
    
    self.filterCategory = nil;
    self.filterFloorModel = nil;
    self.storeInterface.delegate = nil;
    self.storeInterface = nil;
    self.storeList = nil;
    self.refreshHeaderView = nil;
    
    [super dealloc];
}

@end
