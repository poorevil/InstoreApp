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
    
    self.collectionView = [[PullPsCollectionView alloc] initWithFrame:CGRectMake(0, 0,
                                                                                 self.viewParent.frame.size.width,
                                                                                 self.viewParent.frame.size.height)];
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

    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:self.collectionView.bounds];
    loadingLabel.text = @"Loading...";
    loadingLabel.textAlignment = UITextAlignmentCenter;
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
    [self loadDataSource];
    self.collectionView.pullLastRefreshDate = [NSDate date];
    self.collectionView.pullTableIsRefreshing = NO;
    [self.collectionView reloadData];
}

- (void) loadMoreDataToTable
{
    /*
     
     Code to actually load more data goes here.
     
     */
    [self loadDataSource];
//    [self.items addObjectsFromArray:self.items];
//    [self.collectionView reloadData];
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
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//实例化tile
- (YouhuiTileView *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    CouponModel *item = [self.items objectAtIndex:index];
    
    // You should probably subclass PSCollectionViewCell
    YouhuiTileView *v = nil;//(YouhuiTileView *)[self.collectionView dequeueReusableView];
    if(v == nil) {
        NSArray *nib =
        [[NSBundle mainBundle] loadNibNamed:@"YouhuiTileView" owner:self options:nil];
        v = [nib objectAtIndex:0];
    }
    
    [v fillViewWithObject:item];

//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://imgur.com/%@%@", [item objectForKey:@"hash"], [item objectForKey:@"ext"]]];
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
//    [v.picView  setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"placeholder"]];
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
//    // Request
//    NSString *URLPath = [NSString stringWithFormat:@"http://imgur.com/gallery.json"];
//    NSURL *URL = [NSURL URLWithString:URLPath];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
//        
//        if (!error && responseCode == 200) {
//            id res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            if (res && [res isKindOfClass:[NSDictionary class]]) {
//                self.items = [res objectForKey:@"gallery"];
//                [self dataSourceDidLoad];
//            } else {
//                [self dataSourceDidError];
//            }
//        } else {
//            [self dataSourceDidError];
//        }
//    }];
    
    
//    CGFloat objectWidth = [[object objectForKey:@"width"] floatValue];
//    CGFloat objectHeight = [[object objectForKey:@"height"] floatValue];
    
    
    //------------
//    self.items = [NSMutableArray arrayWithArray:@[@{@"width":[NSNumber numberWithFloat:600],
//                                                    @"height":[NSNumber numberWithFloat:398.0f],
//                                                    @"title":@"星巴克",
//                                                    @"icon":@"url.jpg",
//                                                    @"image":@"coffee.jpg"},
//                                                  @{@"width":[NSNumber numberWithFloat:280.0f],
//                                                    @"height":[NSNumber numberWithFloat:365.0f],
//                                                    @"title":@"杰克琼斯",
//                                                    @"icon":@"pp_2.jpg",
//                                                    @"image":@"c_2.jpg"},
//                                                  @{@"width":[NSNumber numberWithFloat:280.0f],
//                                                    @"height":[NSNumber numberWithFloat:365.0f],
//                                                    @"title":@"迪奥",
//                                                    @"icon":@"pp_1.jpg",
//                                                    @"image":@"c_3.jpg"},
//                                                  @{@"width":[NSNumber numberWithFloat:280.0f],
//                                                    @"height":[NSNumber numberWithFloat:365.0f],
//                                                    @"title":@"卡西欧",
//                                                    @"icon":@"pp_4.jpg",
//                                                    @"image":@"c_4.jpg"},
//                                                  @{@"width":[NSNumber numberWithFloat:280.0f],
//                                                    @"height":[NSNumber numberWithFloat:365.0f],
//                                                    @"title":@"可可尼",
//                                                    @"icon":@"pp_3.jpg",
//                                                    @"image":@"c_5.jpg"},]];
    
    self.couponInterface = [[CouponInterface alloc] init];
    self.couponInterface.delegate = self;
    [self.couponInterface getCouponListByCid:@"0"
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
    NSLog(@"%@",errorMessage);
}

@end
