//
//  StoreListFocusedViewController.m
//  InstoreApp
//
//  Created by evil on 14-7-14.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreListFocusedViewController.h"

#import "StoreListFocused_headerView.h"
#import "YouhuiCategoryViewController.h"
#import "YouHuiOrderViewController.h"

#import "YouhuiCategoryViewController.h"
#import "YouHuiOrderViewController.h"
#import "CategoryModel.h"

@interface StoreListFocusedViewController () <YouhuiCategoryViewControllerDelegate,
YouHuiOrderViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray *itemList;

@property (nonatomic, retain) StoreListFocused_headerView *headerView;
@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件
@property (nonatomic,retain) NSString *filterOrder;//排序

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation StoreListFocusedViewController

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
    self.title = @"已关注的商家";
    
    [self initHeaderView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mtableView = nil;
    self.itemList = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)loadItemList
{
    NSString *category = nil;
    NSInteger page = 1;
    
//    self.storeInterface = [[StoreInterface alloc] init];
//    self.storeInterface.delegate = self;
//    
//    [self.storeInterface getStoreListByFloorId:self.filterFloorModel.fid
//                                           cid:self.filterCategory.cid
//                                    buildingId:self.filterFloorModel.buildingId
//                                         order:self.filterOrder
//                                      category:category
//                                        amount:20
//                                          page:page];
}

-(void)initHeaderView
{
    self.headerView = (StoreListFocused_headerView *)[[[NSBundle mainBundle] loadNibNamed:@"StoreListFocused_headerView" owner:self options:nil] objectAtIndex:0];

    self.mtableView.tableHeaderView = self.headerView;
    
    [self.headerView.categoryBtn addTarget:self
                                    action:@selector(categoryBtnAction:)
                          forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.orderBtn addTarget:self
                                 action:@selector(btnOrderAction:)
                       forControlEvents:UIControlEventTouchUpInside];
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
    return 10;//self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"FoodItemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifer
                                             owner:self
                                            options:nil] objectAtIndex:0];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
    
    [self.itemList removeAllObjects];
    self.totalCount = 0;
    self.currentPage = 1;
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
    
    [self.itemList removeAllObjects];
    self.totalCount = 0;
    self.currentPage = 1;
    [self.mtableView reloadData];
    [self loadItemList];
}

@end
