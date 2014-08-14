//
//  StoreListViewController.m
//  InstoreApp
//
//  Created by evil on 14-6-24.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreListViewController.h"

#import "StoreList_headerView.h"
#import "StoreInterface.h"

#import "StoreList_goodsCell.h"
#import "FoodItemCell.h"
#import "StoreModel.h"
#import "StoreDetail_RestaurantViewController.h"

#import "FloorSelectViewController.h"
#import "YouhuiCategoryViewController.h"
#import "YouHuiOrderViewController.h"
#import "CategoryModel.h"
#import "FloorModel.h"

#import "StoreListFocusedViewController.h"
#import "IndoorMapWithLeftPopBtnViewController.h"

@interface StoreListViewController () <UITableViewDataSource, UITableViewDelegate,
StoreInterfaceDelegate,FloorSelectViewControllerDelegate,YouhuiCategoryViewControllerDelegate,
YouHuiOrderViewControllerDelegate>

@property (nonatomic, assign) NSInteger storeCount;

@property (nonatomic, retain) StoreList_headerView *headerView;
//百货
@property (nonatomic, retain) NSMutableArray *goodsItemList;
@property (nonatomic, assign) NSInteger goodsTotalCount;
@property (nonatomic, assign) NSInteger goodsCurrentPage;

//餐饮
@property (nonatomic, retain) NSMutableArray *foodItemList;
@property (nonatomic, assign) NSInteger foodTotalCount;
@property (nonatomic, assign) NSInteger foodCurrentPage;

//娱乐
@property (nonatomic, retain) NSMutableArray *gameItemList;
@property (nonatomic, assign) NSInteger gameTotalCount;
@property (nonatomic, assign) NSInteger gameCurrentPage;

@property (assign, nonatomic) NSInteger everyPageCount;

@property (nonatomic, retain) StoreInterface *storeInterface;


@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件
@property (nonatomic,strong) FloorModel *filterFloorModel;//楼层筛选
@property (nonatomic,retain) NSString *filterOrder;//排序
@end

@implementation StoreListViewController

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
    self.title = @"商户";
    self.goodsItemList = [NSMutableArray array];
    self.foodItemList = [NSMutableArray array];
    self.gameItemList = [NSMutableArray array];
    
    self.everyPageCount = 10;
    
    //init navigater
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f
                                                                             green:40.0f/255.0f
                                                                              blue:53.0f/255.0f
                                                                             alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mapBtn.frame = CGRectMake(0, 0, 30, 30);
    [mapBtn setImage:[UIImage imageNamed:@"nav_map_btn"] forState:UIControlStateNormal];
    [mapBtn addTarget:self action:@selector(showMap) forControlEvents:UIControlEventTouchUpInside];
//    [mapBtn sizeToFit];
    UIBarButtonItem *mapBarBtn = [[[UIBarButtonItem alloc] initWithCustomView:mapBtn] autorelease];
    
    UIButton *favorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    favorBtn.frame = CGRectMake(0, 0, 30, 30);
    [favorBtn setImage:[UIImage imageNamed:@"store_nav_right_love.png"] forState:UIControlStateNormal];
    [favorBtn addTarget:self action:@selector(showFocusedStoreList)
       forControlEvents:UIControlEventTouchUpInside];
//    [favorBtn sizeToFit];
    UIBarButtonItem *favorBarBtn = [[[UIBarButtonItem alloc] initWithCustomView:favorBtn] autorelease];
    
    self.navigationItem.rightBarButtonItems =@[mapBarBtn,favorBarBtn];
    
    [self initHeaderView];
    
    [self loadItemList];
    
    [self initNavBarView];
}

-(void)initNavBarView{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 27)]autorelease];
    view.backgroundColor = [UIColor clearColor];

    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 27)];
    textField.placeholder = @"    输入品牌、商户、优惠";
    textField.font = [UIFont systemFontOfSize:12];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:textField];
    [textField release];
    
    UIImageView *imageSearchIcon = [[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 14, 14)];
    imageSearchIcon.image = [UIImage imageNamed:@"nav_search_gray.png"];
    [view addSubview:imageSearchIcon];
    [imageSearchIcon release];
    
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(0, 0, 150, 27);
    [btnSearch addTarget:self action:@selector(showSearchView:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnSearch];

    self.navigationItem.titleView = view;
}

-(void)loadItemList
{
    NSString *category = nil;
    NSInteger page = 1;
    
    switch (self.headerView.segmentControl.selectedSegmentIndex) {
        case 0:
            category = @"Department";
            page = self.goodsCurrentPage;
            break;
        //TODO:
        case 1:
            category = @"Restaurant";
            page = self.foodCurrentPage;
            break;
        case 2:
            category = @"Entertainment";
            page = self.foodCurrentPage;
            break;
        default:
            category = @"Department";
            page = self.goodsCurrentPage;
            break;
    }
    
    if (!self.storeInterface) {
        self.storeInterface = [[[StoreInterface alloc] init]autorelease];
        self.storeInterface.delegate = self;
    }
    
    [self.storeInterface getStoreListByFloorId:self.filterFloorModel.fid
                                           cid:self.filterCategory.cid
                                    buildingId:self.filterFloorModel.buildingId
                                         order:self.filterOrder
                                      category:category
                                        amount:self.everyPageCount
                                          page:page];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mtableView = nil;
    self.headerView = nil;
    
    self.goodsItemList = nil;
    self.foodItemList = nil;
    self.gameItemList = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)showMap
{
    IndoorMapWithLeftPopBtnViewController *imvc = [[[IndoorMapWithLeftPopBtnViewController alloc] initWithFrame:self.view.bounds] autorelease];
    imvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imvc animated:YES];
}

-(void)showFocusedStoreList
{
    StoreListFocusedViewController *vc = [[StoreListFocusedViewController alloc] initWithNibName:@"StoreListFocusedViewController" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

-(void)initHeaderView
{
    if (!self.headerView) {
        self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"StoreList_headerView"
                                                        owner:self
                                                       options:nil] objectAtIndex:0];
        
        self.mtableView.tableHeaderView = self.headerView;
        [self.headerView.segmentControl addTarget:self
                                           action:@selector(segmentChanged:)
                                 forControlEvents:UIControlEventValueChanged];
        
        [self.headerView.floorBtn addTarget:self
                                     action:@selector(floorBtnAction:)
                           forControlEvents:UIControlEventTouchUpInside];
        [self.headerView.categoryBtn addTarget:self
                                     action:@selector(categoryBtnAction:)
                           forControlEvents:UIControlEventTouchUpInside];
        [self.headerView.orderBtn addTarget:self
                                     action:@selector(btnOrderAction:)
                           forControlEvents:UIControlEventTouchUpInside];
        
        [self.headerView.segmentControl setSelectedSegmentIndex:0];
    }
}

-(void)segmentChanged:(id)sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
            [self.headerView hideFilterView:NO];
            if (self.goodsItemList.count==0) {
                [self loadItemList];
            }
            break;
        case 1:
            [self.headerView hideFilterView:YES];
            if (self.foodItemList.count==0) {
                [self loadItemList];
//                return;
            }
            break;
        case 2:
            [self.headerView hideFilterView:YES];
            if (self.gameItemList.count==0) {
                [self loadItemList];
//                return;
            }
            break;
    }
    
    self.mtableView.tableHeaderView = self.headerView;
    
    [self.mtableView reloadData];
}

#pragma mark - header btn method
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

- (IBAction)btnOrderAction:(UIButton *)sender {
    YouHuiOrderViewController *vc= [[YouHuiOrderViewController alloc]init];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
    [vc release];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.headerView.segmentControl.selectedSegmentIndex) {
        case 0:
            return self.goodsItemList.count;
        case 1:
            return self.foodItemList.count;
        case 2:
            return self.gameItemList.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = nil;
    //TODO:判断
    switch (self.headerView.segmentControl.selectedSegmentIndex) {
        case 0:
            cellIdentifer = @"StoreList_goodsCell";
            break;
        case 1:
            cellIdentifer = @"FoodItemCell";
            break;
        case 2:
            cellIdentifer = @"StoreList_goodsCell";
            break;
        default:
            cellIdentifer = @"StoreList_goodsCell";
            break;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifer
                                             owner:self
                                            options:nil] objectAtIndex:0];
    }
    
    StoreModel *sm = nil;
    
    switch ([self.headerView.segmentControl selectedSegmentIndex]) {
        case 0:
            sm = [self.goodsItemList objectAtIndex:indexPath.row];
            break;
        case 1:
            sm = [self.foodItemList objectAtIndex:indexPath.row];
            break;
        case 2:
            sm = [self.gameItemList objectAtIndex:indexPath.row];
            break;
    }
    
    if ([cell isMemberOfClass:[StoreList_goodsCell class]]) {
        StoreList_goodsCell *goodsCell = (StoreList_goodsCell *)cell;
        goodsCell.storeModel = sm;
    }else if ([cell isMemberOfClass:[FoodItemCell class]]){
        FoodItemCell *foodCell = (FoodItemCell *)cell;
        foodCell.storeModel = sm;
    }
    
    switch ([self.headerView.segmentControl selectedSegmentIndex]) {
        case 0:
            if (indexPath.row == self.goodsItemList.count -1) {
                if (self.goodsCurrentPage * self.everyPageCount < self.goodsTotalCount) {
                    self.goodsCurrentPage++;
                    [self loadItemList];
                }
            }
            break;
        case 1:
            if (indexPath.row == self.foodItemList.count -1) {
                if (self.foodCurrentPage * self.everyPageCount < self.foodTotalCount) {
                    self.foodCurrentPage++;
                    [self loadItemList];
                }
            }
            break;
        case 2:
            if (indexPath.row == self.gameItemList.count -1) {
                if (self.gameCurrentPage * self.everyPageCount < self.gameTotalCount) {
                    self.gameCurrentPage++;
                    [self loadItemList];
                }
            }
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.headerView.segmentControl.selectedSegmentIndex) {
        case 0:
            return 63;
        case 1:
            return 80;
        case 2:
            return 63;
        default:
            return 63;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StoreModel *sm = nil;
    switch ([self.headerView.segmentControl selectedSegmentIndex]) {
        case 0:
            sm = [self.goodsItemList objectAtIndex:indexPath.row];
            break;
        case 1:
            sm = [self.foodItemList objectAtIndex:indexPath.row];
            break;
        case 2:
            sm = [self.gameItemList objectAtIndex:indexPath.row];
            break;
    }
    
    StoreDetail_RestaurantViewController *sdrvc = [[StoreDetail_RestaurantViewController alloc] initWithNibName:@"StoreDetail_RestaurantViewController" bundle:nil];
    sdrvc.shopId = sm.sid;
    sdrvc.title = sm.title;
    sdrvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sdrvc animated:YES];
    sdrvc.hidesBottomBarWhenPushed = NO;
    [sdrvc release];
}


#pragma mark - StoreInterfaceDelegate <NSObject>

-(void)getStoreListDidFinished:(NSArray *)resultList
                    totalCount:(NSInteger)totalCount
                    storeCount:(NSInteger)storeCount    //用户关注的商家数
                   currentPage:(NSInteger)currentPage
                      category:(NSString *)category
{
    if ([category isEqualToString:@"Department"]) {
        [self.goodsItemList addObjectsFromArray:resultList];
        self.goodsTotalCount = totalCount;
        self.goodsCurrentPage = currentPage;
//        self.goodsCurrentPage++;
    }else if ([category isEqualToString:@"Restaurant"]) {
        [self.foodItemList addObjectsFromArray:resultList];
        self.foodTotalCount = totalCount;
        self.foodCurrentPage = currentPage;
//        self.foodCurrentPage++;
    }else if ([category isEqualToString:@"Entertainment"]) {
        [self.gameItemList addObjectsFromArray:resultList];
        self.gameTotalCount = totalCount;
        self.gameCurrentPage = currentPage;
//        self.gameCurrentPage++;
    }
    
    self.storeCount = storeCount;
    
    [self.mtableView reloadData];
}

-(void)getStoreListDidFailed:(NSString *)errorMessage
{
    DebugLog(@"%@",errorMessage);
}

#pragma mark - FloorSelectViewControllerDelegate
-(void)floorSelectDidFinished:(FloorModel *) floorModel
{
    self.filterFloorModel = floorModel;
    
    if (self.filterFloorModel) {
        [self.headerView.floorBtn setTitle:[NSString stringWithFormat:@"%@ ",self.filterFloorModel.fName]
                       forState:UIControlStateNormal];
    }else{
        [self.headerView.floorBtn setTitle:@"楼层 " forState:UIControlStateNormal];
    }
    
    [self.goodsItemList removeAllObjects];
    self.goodsTotalCount = 0;
    self.goodsCurrentPage = 1;
    [self.mtableView reloadData];
    
    [self loadItemList];
}

#pragma mark - YouhuiCategoryViewControllerDelegate
-(void)categoryDidSelected:(CategoryModel *)categoryModel
{
    self.filterCategory = categoryModel;
    if (self.filterCategory) {
        [self.headerView.categoryBtn setTitle:[NSString stringWithFormat:@"%@ ",categoryModel.cName]
                      forState:UIControlStateNormal];
    }else{
        [self.headerView.categoryBtn setTitle:@"分类 " forState:UIControlStateNormal];
    }
    
    [self.goodsItemList removeAllObjects];
    self.goodsTotalCount = 0;
    self.goodsCurrentPage = 1;
    [self.mtableView reloadData];
    [self loadItemList];
}

#pragma mark - @protocol YouHuiOrderViewControllerDelegate
-(void)youHuiOrderViewControllerDidSelected:(NSUInteger)index
{
    //@[@"默认排序",@"人气优先",@"收藏数量",@"结束时间"];
    switch (index) {
        case 0: {
            self.filterOrder = @"";
            [self.headerView.orderBtn setTitle:@"默认排序" forState:UIControlStateNormal];
        }
            break;
        case 1:{
            self.filterOrder = @"hot";
            [self.headerView.orderBtn setTitle:@"人气优先" forState:UIControlStateNormal];
        }
            break;
        case 2:{
            self.filterOrder = @"collect";
            [self.headerView.orderBtn setTitle:@"收藏数量" forState:UIControlStateNormal];
        }
            break;
        case 3:{
            self.filterOrder = @"latest";
            [self.headerView.orderBtn setTitle:@"结束时间" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    [self.goodsItemList removeAllObjects];
    self.goodsTotalCount = 0;
    self.goodsCurrentPage = 1;
    [self.mtableView reloadData];
    [self loadItemList];
}

-(void)showSearchView:(id)sender;
{
    [super showSearchView];
}

@end
