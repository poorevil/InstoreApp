//
//  YouhuiViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "YouhuiViewController.h"
#import "YouhuiTileView.h"
#import "YouhuiCategoryViewController.h"
#import "CategoryModel.h"
#import "CouponInterface.h"
#import "CouponModel.h"

@interface YouhuiViewController ()<YouhuiCategoryViewControllerDelegate,CouponInterfaceDelegate>

@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件
@property (nonatomic,strong) CouponInterface *couponInterface;

@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation YouhuiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.items = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.currentPage = 1;
    
    self.title = @"优惠劵";
    
    self.collectionView = [[[PullPsCollectionView alloc] initWithFrame:CGRectMake(0, 0,
                                                                                 self.viewParent.frame.size.width,
                                                                                 self.viewParent.frame.size.height)] autorelease];
    [self.viewParent addSubview:self.collectionView];
    self.collectionView.collectionViewDelegate = self;
    self.collectionView.collectionViewDataSource = self;
    self.collectionView.pullDelegate=self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.collectionView.numColsPortrait = 2;
    self.collectionView.numColsLandscape = 3;
    
    self.collectionView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    self.collectionView.pullBackgroundColor = [UIColor whiteColor];
    self.collectionView.pullTextColor = [UIColor blackColor];

    UILabel *loadingLabel = [[[UILabel alloc] initWithFrame:self.collectionView.bounds] autorelease];
    loadingLabel.text = @"Loading...";
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.collectionView.loadingView = loadingLabel;
    
    //    [self loadDataSource];
    if(!self.collectionView.pullTableIsRefreshing) {
        self.collectionView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0];
    }

    
    [self.categoryBtn addTarget:self
                         action:@selector(categoryBtnAction:)
               forControlEvents:UIControlEventTouchUpInside];
    [self.orderBtn addTarget:self
                         action:@selector(orderBtnAction:)
               forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) refreshTable
{
    /*
     Code to actually refresh goes here.
     */
    
    [self.items removeAllObjects];
    self.currentPage = 1;
    [self loadDataSource];
    self.collectionView.pullLastRefreshDate = [NSDate date];
    self.collectionView.pullTableIsRefreshing = NO;
    [self.collectionView reloadData];
}

- (void) loadMoreDataToTable
{

    [self loadDataSource];
    self.collectionView.pullTableIsLoadingMore = NO;
}


#pragma mark - private method
-(void)categoryBtnAction:(id)sender
{
    YouhuiCategoryViewController *cateVC = [[YouhuiCategoryViewController alloc] initWithCategoryModel:self.filterCategory];
    cateVC.delegate = self;
    cateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cateVC animated:YES];
    cateVC.hidesBottomBarWhenPushed = NO;
}

-(void)orderBtnAction:(id)sender
{
    
}


#pragma mark - PullTableViewDelegate

- (void)pullPsCollectionViewDidTriggerRefresh:(PullPsCollectionView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
}

- (void)pullPsCollectionViewDidTriggerLoadMore:(PullPsCollectionView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}
- (void)viewDidUnload
{
    [self setCollectionView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//实例化tile
- (YouhuiTileView *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    CouponModel *item = [self.items objectAtIndex:index];

    YouhuiTileView *v = nil;//(YouhuiTileView *)[self.collectionView dequeueReusableView];
    if(v == nil) {
        NSArray *nib =
        [[NSBundle mainBundle] loadNibNamed:@"YouhuiTileView" owner:self options:nil];
        v = [nib objectAtIndex:0];
    }
    
    [v fillViewWithObject:item];

    return v;
}

//根据图片高度返回tile高度
- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    // You should probably subclass PSCollectionViewCell
    return [YouhuiTileView heightForViewWithObject:[self.items objectAtIndex:index] inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
    // Do something with the tap
}

- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return [self.items count];
}



//获取接口数据
- (void)loadDataSource {
    self.couponInterface = [[[CouponInterface alloc] init] autorelease];
    self.couponInterface.delegate = self;
    [self.couponInterface getCouponListByCid:[NSString stringWithFormat:@"%d",self.filterCategory.cid]
                                      isLike:0
                                       order:@"startTime,desc"
                                      amount:20
                                        page:self.currentPage];
    
}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}

- (void)dataSourceDidError {
    [self.collectionView reloadData];
}

#pragma mark - YouhuiCategoryViewControllerDelegate
-(void)categoryDidSelected:(CategoryModel *)categoryModel
{
    self.filterCategory = categoryModel;
    if (self.filterCategory) {
        [self.categoryBtn setTitle:[NSString stringWithFormat:@"%@ ",categoryModel.cName]
                          forState:UIControlStateNormal];
    }else{
        [self.categoryBtn setTitle:@"分类 " forState:UIControlStateNormal];
    }
    
    [self refreshTable];
}

#pragma mark - CouponInterfaceDelegate <NSObject>

-(void)getCouponListDidFinished:(NSArray *)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage
{
    [self.items addObjectsFromArray:result];
    [self dataSourceDidLoad];
    
    self.currentPage++;
}

-(void)getCouponListDidFailed:(NSString *)errorMessage
{
    DebugLog(@"%@",errorMessage);
}

-(void)dealloc
{
    self.collectionView = nil;
    self.collectionView.pullDelegate = nil;
    self.collectionView.collectionViewDelegate = nil;
    self.collectionView.collectionViewDataSource = nil;
    
    self.items = nil;
    self.optionView = nil;
    self.segmentedControl = nil;
    self.categoryBtn = nil;
    self.orderBtn = nil;
    self.viewParent = nil;
    self.filterCategory = nil;
    self.couponInterface = nil;
    
    [super dealloc];
}
@end
