//
//  DownloadCouponsViewController.m
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "DownloadCouponsViewController.h"
#import "YouhuiTileView.h"
#import "CouponsDownloadListInterface.h"
#import "CouponModel.h"


@interface DownloadCouponsViewController () <CouponsDownloadListInterfaceDelegate>

@property (nonatomic,strong) CouponsDownloadListInterface *couponsDownloadListInterface;
@property (nonatomic,assign) NSInteger currentPage;
@end

@implementation DownloadCouponsViewController

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
    self.items = [NSMutableArray array];
    self.currentPage = 1;
    self.title = @"我的优惠劵";
    
    self.collectionView = [[[PullPsCollectionView alloc] initWithFrame:CGRectMake(0, 0,
                                                                                 self.view.frame.size.width,
                                                                                 self.view.frame.size.height)] autorelease];
    [self.view addSubview:self.collectionView];
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
    
    if(!self.collectionView.pullTableIsRefreshing) {
        self.collectionView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshTable
{
    [self.items removeAllObjects];
    [self loadDataSource];
    self.currentPage = 1;
    self.collectionView.pullLastRefreshDate = [NSDate date];
    self.collectionView.pullTableIsRefreshing = NO;
    [self.collectionView reloadData];
}

- (void) loadMoreDataToTable
{
    [self loadDataSource];
    self.collectionView.pullTableIsLoadingMore = NO;
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
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//实例化tile
- (YouhuiTileView *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    CouponModel *item = [self.items objectAtIndex:index];
    
    //TODO:重用view！！
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
    self.couponsDownloadListInterface = [[[CouponsDownloadListInterface alloc] init] autorelease];
    self.couponsDownloadListInterface.delegate = self;
    [self.couponsDownloadListInterface getCouponsDownloadList];
    
}

- (void)dataSourceDidLoad {
    [self.collectionView reloadData];
}

- (void)dataSourceDidError {
    [self.collectionView reloadData];
}

#pragma mark - CouponsDownloadListInterfaceDelegate <NSObject>
-(void)getCouponsDownloadListDidFinished:(NSArray *)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage
{
    [self.items addObjectsFromArray:result];
    [self dataSourceDidLoad];
    
    self.currentPage++;
}

-(void)getCouponsDownloadListFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

-(void)dealloc{
    self.couponsDownloadListInterface.delegate = nil;
    self.couponsDownloadListInterface = nil;
    
    self.collectionView.collectionViewDelegate = nil;
    self.collectionView.collectionViewDataSource = nil;
    self.collectionView.pullDelegate=nil;
    self.collectionView = nil;
    self.items = nil;
    
    [super dealloc];
}

@end
