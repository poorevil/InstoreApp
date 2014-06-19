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


@interface FoodViewController () <FoodViewInterfaceDelegate, FoodViewPromotionInterfaceDelegate>
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

@end

@implementation FoodViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"美食";
    self.currentPage = 1;
    self.itemList = [NSMutableArray array];
    self.itemCouponList = [NSMutableArray array];
    
    [self initLunboView];
    
    //TODO:111
    [self showTypeChanged:self.segmentedControl];
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
    
    [super dealloc];
}

#pragma mark - private method
-(void)initLunboView
{
    NSArray *imageFileName = @[@"banner_1.jpg",@"banner_2.jpg",@"banner_3.jpg",@"banner_4.jpg",@"banner_5.jpg"];
    NSMutableArray *viewsArray = [NSMutableArray array];
    for (int i = 0; i < imageFileName.count; ++i) {
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
        imageView.image = [UIImage imageNamed:[imageFileName objectAtIndex:i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [viewsArray addObject:imageView];
    }
    
    self.lunboView = [[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)
                                           animationDuration:5] autorelease];
    self.lunboView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.lunboView.totalPagesCount = ^NSInteger(void){
        return imageFileName.count;
    };
    self.lunboView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",pageIndex);
    };
    
    self.headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 152)] autorelease];
    [self.headerView addSubview:self.lunboView];
    
    self.segmentedControl = [[[UISegmentedControl alloc] initWithItems:@[@"餐厅",@"优惠"]] autorelease];
    self.segmentedControl.frame = CGRectMake(65,
                                             112,
                                             190,
                                             29);
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = [UIColor colorWithRed:229/255.0f
                                                       green:63/255.0f
                                                        blue:17/255.0f
                                                       alpha:1];
    [self.segmentedControl addTarget:self
                              action:@selector(showTypeChanged:)
                    forControlEvents:UIControlEventValueChanged];
    
    [self.headerView addSubview:self.segmentedControl];
    
    self.mtableView.tableHeaderView = self.headerView;
    
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

@end
