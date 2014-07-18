//
//  FoodViewController.m
//  InstoreApp
//
//  Created by evil on 14-6-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FoodViewController.h"

#import "CycleScrollView.h"
#import "FoodViewInterface.h"
#import "StoreModel.h"
#import "FoodItemCell.h"
#import "EGOImageView.h"
#import "PositionModel.h"
#import "FloorModel.h"
#import "FoodCouponCell.h"

#import "FoodViewPromotionInterface.h"

#import "LunBoImageInterface.h"
#import "GroupBuyDetailViewController.h"
#import "CouponDetailViewController.h"
#import "MallNewsDetailViewController.h"
#import "WebViewController.h"
#import "AppDelegate.h"


@interface FoodViewController () <FoodViewInterfaceDelegate, FoodViewPromotionInterfaceDelegate,LunBoImageInterfaceDelegate>
@property (nonatomic,strong) CycleScrollView *lunboView;

@property (nonatomic, retain) NSMutableArray *itemList;
@property (nonatomic, retain) NSMutableArray *itemCouponList;

@property (nonatomic, retain) FoodViewInterface *foodViewInterface;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalCount;

@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;

@property (nonatomic, retain) FoodViewPromotionInterface *foodViewPromotionInterface;
@property (nonatomic, assign) NSInteger promotion_currentPage;
@property (nonatomic, assign) NSInteger promotion_totalCount;

@property (retain, nonatomic) LunBoImageInterface *lunBoImageInterface;
@property (retain, nonatomic) NSArray *itemLunBoImageList;

@end

@implementation FoodViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"美食";
    self.currentPage = 1;
    self.itemList = [NSMutableArray array];
    self.itemCouponList = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = nil;
    
    //TODO:111
    [self showTypeChanged:self.segmentedControl];
    
    self.lunBoImageInterface = [[[LunBoImageInterface alloc]init]autorelease];
    self.lunBoImageInterface.delegate = self;
    [self.lunBoImageInterface getLunBoImageListWithPos:2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.lunboView = nil;
    self.mtableView = nil;
    
    self.itemList = nil;
    
    self.headerView = nil;

    self.foodViewInterface.delegate = nil;
    self.foodViewInterface = nil;
    
    self.lunBoImageInterface = nil;
    self.itemLunBoImageList = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)initLunboView
{
    //    NSArray *imageFileName = @[@"banner_1.jpg",@"banner_2.jpg",@"banner_3.jpg",@"banner_4.jpg",@"banner_5.jpg"];
    //    NSMutableArray *viewsArray = [NSMutableArray array];
    //    for (int i = 0; i < imageFileName.count; ++i) {
    //        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)] autorelease];
    //        imageView.image = [UIImage imageNamed:[imageFileName objectAtIndex:i]];
    //        imageView.contentMode = UIViewContentModeScaleAspectFill;
    //        imageView.clipsToBounds = YES;
    //        imageView.tag = i +1000;
    //        [viewsArray addObject:imageView];
    //
    //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    //        [imageView addGestureRecognizer:tap];
    //        [tap release];
    //    }
    //
    //    self.lunboView = [[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)
    //                                          animationDuration:5] autorelease];
    //    self.lunboView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
    //        return viewsArray[pageIndex];
    //    };
    //    self.lunboView.totalPagesCount = ^NSInteger(void){
    //        return imageFileName.count;
    //    };
    //    self.lunboView.TapActionBlock = ^(NSInteger pageIndex){
    //        NSLog(@"点击了第%d个",pageIndex);
    //    };
    //
    //    self.mtableView.tableHeaderView = self.lunboView;
    
    
    
    NSMutableArray *viewsArray = [NSMutableArray array];
    if (self.itemLunBoImageList.count > 0) {
        for (int i = 0 ; i < self.itemLunBoImageList.count; i++) {
            CouponModel *couponModel = [self.itemLunBoImageList objectAtIndex:i];
            
            EGOImageView *egoImageView = [[[EGOImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)]autorelease];
            egoImageView.contentMode = UIViewContentModeScaleAspectFit;
            egoImageView.imageURL = [NSURL URLWithString:couponModel.imageUrl];
            
            [viewsArray addObject:egoImageView];
        }
    }
    
    self.lunboView = [[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)
                                           animationDuration:5] autorelease];
    self.lunboView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.lunboView.totalPagesCount = ^NSInteger(void){
        return self.itemLunBoImageList.count;
    };
    self.lunboView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",pageIndex);
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
        
        
        CouponModel *couponModel = [self.itemLunBoImageList objectAtIndex:pageIndex];
        int itemType = couponModel.itemType;
        switch (itemType) {
            case 1:
            {
                [nav.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f green:40.0f/255.0f blue:53.0f/255.0f alpha:1]];
                [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
                
                int promotionType = couponModel.promotionType;
                //优惠
                switch (promotionType) {
                    case 1:
                    {
                        //优惠活动
                        WebViewController *webVC = [[WebViewController alloc]init];
                        webVC.hidesBottomBarWhenPushed = YES;
                        webVC.urlStr = couponModel.link;
                        webVC.titleStr = @"优惠详情";
                        [nav pushViewController:webVC animated:YES];
                        [webVC release];
                    }
                        break;
                    case 2:
                    {
                        //优惠券
                        CouponDetailViewController *coupnDVC = [[CouponDetailViewController alloc]init];
                        coupnDVC.couponModel = couponModel;
                        coupnDVC.couponModel.cid = couponModel.itemId;
                        coupnDVC.hidesBottomBarWhenPushed = YES;
                        [nav pushViewController:coupnDVC animated:YES];
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
                        [nav pushViewController:groupBuyDVC animated:YES];
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
                
                [nav.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f green:40.0f/255.0f blue:53.0f/255.0f alpha:1]];
                [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
                
                WebViewController *webVC = [[WebViewController alloc]init];
                webVC.hidesBottomBarWhenPushed = YES;
                webVC.urlStr = couponModel.link;
                webVC.titleStr = @"优惠详情";
                [nav pushViewController:webVC animated:YES];
                [webVC release];
            }
                break;
            default:
                break;
        }
    };
    
    self.mtableView.tableHeaderView = self.lunboView;
    
}

-(void)showTypeChanged:(id)sender
{
    if ([sender selectedSegmentIndex] == 0) {
        //商户
        self.foodViewInterface = [[FoodViewInterface alloc] init];
        self.foodViewInterface.delegate = self;
        [self.foodViewInterface getFoodListByPage:self.currentPage amount:20];
        
    }else{
        //优惠
        self.foodViewPromotionInterface = [[FoodViewPromotionInterface alloc] init];
        self.foodViewPromotionInterface.delegate = self;
        [self.foodViewPromotionInterface getFoodViewPromotionListByPage:self.promotion_currentPage amount:20];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return self.itemList.count;
    }else{
        return ceil((float)self.itemCouponList.count/2);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = nil;
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        cellIdentifer = @"FoodItemCell";
    }else{
        cellIdentifer = @"FoodCouponCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifer
                                             owner:self
                                           options:nil] objectAtIndex:0];
    }
    
    if ([cellIdentifer isEqualToString:@"FoodItemCell"]) {
        StoreModel *store = [self.itemList objectAtIndex:indexPath.row];
        FoodItemCell *fic = (FoodItemCell*)cell;
        fic.storeModel = store;
    }else if ([cellIdentifer isEqualToString:@"FoodCouponCell"]){
        FoodCouponCell *fcc = (FoodCouponCell*)cell;
        fcc.cm1 = [self.itemCouponList objectAtIndex:(indexPath.row*2)];
        if (self.itemCouponList.count > (indexPath.row*2+1)) {
            fcc.cm2 = [self.itemCouponList objectAtIndex:(indexPath.row*2+1)];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return 80;
    }else{
        return 236;
    }
}

#pragma mark - FoodViewInterfaceDelegate <NSObject>
-(void)getFoodListDidFinished:(NSArray *)resultList
                   totalCount:(NSInteger)totalCount
                  currentPage:(NSInteger)currentPage
{
    [self.itemList addObjectsFromArray:resultList];
    self.currentPage++;
    self.totalCount = totalCount;
    
    [self.mtableView reloadData];
}

-(void)getFoodListDidFailed:(NSString *)errorMsg
{
    NSLog(@"%@",errorMsg);
}

#pragma mark - FoodViewPromotionInterfaceDelegate <NSObject>

-(void)getFoodViewPromotionListDidFinished:(NSArray *)itemList
                                totalCount:(NSInteger)totalCount
                               currentPage:(NSInteger)currentPage
{
    [self.itemCouponList addObjectsFromArray:itemList];
    self.promotion_currentPage++;
    self.promotion_totalCount = totalCount;
    
    [self.mtableView reloadData];
}

-(void)getFoodViewPromotionListDidFailed:(NSString *)errorMsg
{
    NSLog(@"%@",errorMsg);
}

#pragma mark - LunBoImageInterfaceDelegate
-(void)getLunBoImageListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount{
    self.itemLunBoImageList = itemList;
    
    [self initLunboView];
    
    [self.mtableView reloadData];
}
-(void)getLunBoImageListDidFailed:(NSString *)errorMsg{
    NSLog(@"%@",errorMsg);
}

@end
