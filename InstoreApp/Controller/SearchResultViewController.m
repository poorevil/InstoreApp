//
//  SearchResultViewController.m
//  InstoreApp
//
//  Created by evil on 14-5-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SearchResultViewController.h"
#import "YouhuiTileView.h"
#import "SearchInterface.h"
#import "CouponModel.h"
#import "StoreModel.h"

@interface SearchResultViewController () <UISearchBarDelegate,SearchInterfaceDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) SearchInterface *searchInterface;
@property (nonatomic,assign) NSInteger currentPage;

@property (retain, nonatomic) NSArray *storeList;

@end

@implementation SearchResultViewController

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
    // Do any additional setup after loading the view.
    
    [self initViews];
    
    self.searchInterface = [[[SearchInterface alloc] init] autorelease];
    self.searchInterface.delegate = self;
    
//    if(!self.collectionView.pullTableIsRefreshing) {
//        self.collectionView.pullTableIsRefreshing = YES;
//        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0];
//    }
}

-(void)initViews
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f
                                                                             green:40.0f/255.0f
                                                                              blue:53.0f/255.0f
                                                                             alpha:1]];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    cancelBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelBtn;
    
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];
    self.searchBar.placeholder = @"请输入关键词";
    self.searchBar.text = self.searchKeyWord;
    self.searchBar.delegate = self;
    
    [self.searchBar setTintColor:[UIColor lightGrayColor]];
    [self.searchBar sizeToFit];
    
    self.navigationItem.titleView = self.searchBar;
    
    
    
    self.items = [NSMutableArray array];
    self.currentPage = 1;
    self.title = @"我的优惠劵";
    
//    self.collectionView = [[[PullPsCollectionView alloc] initWithFrame:CGRectMake(0,
//                                                                                 self.navigationController.navigationBar.frame.size.height+self.navigationController.navigationBar.frame.origin.y,
//                                                                                  self.view.frame.size.width,
//                                                                                  self.view.frame.size.height-(self.navigationController.navigationBar.frame.size.height+self.navigationController.navigationBar.frame.origin.y))] autorelease];
//    [self.view addSubview:self.collectionView];
//    self.collectionView.collectionViewDelegate = self;
//    self.collectionView.collectionViewDataSource = self;
//    self.collectionView.pullDelegate=self;
//    self.collectionView.backgroundColor = [UIColor clearColor];
//    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    self.collectionView.numColsPortrait = 2;
//    self.collectionView.numColsLandscape = 3;
//    
//    self.collectionView.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
//    self.collectionView.pullBackgroundColor = [UIColor whiteColor];
//    self.collectionView.pullTextColor = [UIColor blackColor];
//    
//    UILabel *loadingLabel = [[[UILabel alloc] initWithFrame:self.collectionView.bounds] autorelease];
//    loadingLabel.text = @"Loading...";
//    loadingLabel.textAlignment = NSTextAlignmentCenter;
//    self.collectionView.loadingView = loadingLabel;
//    
//    self.collectionView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshTable
{
    [self.items removeAllObjects];
    self.currentPage = 1;
    [self loadDataSource];
//    self.collectionView.pullLastRefreshDate = [NSDate date];
//    self.collectionView.pullTableIsRefreshing = NO;
//    [self.collectionView reloadData];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.storeList.count;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return ceil(self.items.count / 2.0);
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
                cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
            }
            cell.textLabel.text = @"品牌";
        }
            break;
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
                cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
            }
            cell.textLabel.text = @"优惠";
        }
            break;
        case 1:{
            if (self.storeList.count > 0) {
                StoreModel *storeModel = [self.storeList objectAtIndex:indexPath.row];
                if (storeModel.appCategory) {
#warning 7月15日
                }
            }
        }
    
            break;
            
        default:
            break;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        //品牌  其他不用点
        
    }
}



//- (void) loadMoreDataToTable
//{
//    [self loadDataSource];
//    self.collectionView.pullTableIsLoadingMore = NO;
//}
//
//#pragma mark - PullTableViewDelegate
//
//- (void)pullPsCollectionViewDidTriggerRefresh:(PullPsCollectionView *)pullTableView
//{
//    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
//}
//
//- (void)pullPsCollectionViewDidTriggerLoadMore:(PullPsCollectionView *)pullTableView
//{
//    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
//}


//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

////实例化tile
//- (YouhuiTileView *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
//    CouponModel *item = [self.items objectAtIndex:index];
//    
//    //TODO:重用view！！
//    YouhuiTileView *v = nil;//(YouhuiTileView *)[self.collectionView dequeueReusableView];
//    if(v == nil) {
//        NSArray *nib =
//        [[NSBundle mainBundle] loadNibNamed:@"YouhuiTileView" owner:self options:nil];
//        v = [nib objectAtIndex:0];
//    }
//    
//    [v fillViewWithObject:item];
//    
//    return v;
//}
//
////根据图片高度返回tile高度
//- (CGFloat)heightForViewAtIndex:(NSInteger)index {
//    // You should probably subclass PSCollectionViewCell
//    return [YouhuiTileView heightForViewWithObject:[self.items objectAtIndex:index] inColumnWidth:self.collectionView.colWidth];
//}
//
//- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
//    // Do something with the tap
//}
//
//- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
//    return [self.items count];
//}



//获取接口数据
- (void)loadDataSource {    
    [self.searchInterface searchKeyword:self.searchKeyWord
                                   type:0
                                orderBy:nil
                                 amount:20 page:self.currentPage];
}

//- (void)dataSourceDidLoad {
//    [self.collectionView reloadData];
//}
//
//- (void)dataSourceDidError {
//    [self.collectionView reloadData];
//}

#pragma mark - SearchInterfaceDelegate
-(void)searchDidFinished:(NSDictionary *)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
{
    [self.items addObjectsFromArray:[result objectForKey:@"couponList"]];
    self.storeList = [result objectForKey:@"storeList"];
//    [self dataSourceDidLoad];
    [self.myTableView reloadData];
    
    self.currentPage++;
}

-(void)searchDidFailed:(NSString*)errorMessage
{
    NSLog(@"%@",errorMessage);
}

#pragma mark - private method
-(void)cancelAction
{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
        [self.navigationItem.rightBarButtonItem setTitle:@"关闭"];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.navigationItem.rightBarButtonItem setTitle:@"取消"];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    self.searchKeyWord = self.searchBar.text;
    [self refreshTable];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

-(void)dealloc
{
    self.items = nil;
    self.searchKeyWord = nil;
//    self.collectionView = nil;
    self.searchBar = nil;
    self.searchInterface.delegate = nil;
    self.searchInterface = nil;
    
    [_myTableView release];
    [super dealloc];
}
@end
