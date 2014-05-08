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

#import "StoreInterface.h"
#import "StoreModel.h"

@interface ShopViewController () <FloorSelectViewControllerDelegate,YouhuiCategoryViewControllerDelegate,StoreInterfaceDelegate>

@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件
@property (nonatomic,strong) FloorModel *filterFloorModel;//楼层筛选

@property (nonatomic,strong) StoreInterface *storeInterface;
@property (nonatomic,strong) NSMutableArray *storeList;
@property (nonatomic,assign) NSInteger currentPage;

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
    
    self.storeList = [NSMutableArray array];
    self.title = @"商户";
    
    [self.floorBtn addTarget:self action:@selector(floorBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.cateBtn addTarget:self action:@selector(categoryBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    
    self.storeInterface = [[StoreInterface alloc] init];
    self.storeInterface.delegate = self;
    [self.storeInterface getStoreListByFloor:nil
                                         cid:0
                                       order:nil
                                      isLike:0
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
    
    ShopDetailViewController *shopDetailVC = [[ShopDetailViewController alloc]
                                              initWithNibName:@"ShopDetailViewController"
                                              bundle:nil];
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

@end
