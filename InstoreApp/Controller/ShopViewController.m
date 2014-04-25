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

@interface ShopViewController () <FloorSelectViewControllerDelegate,YouhuiCategoryViewControllerDelegate>

@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件
@property (nonatomic,strong) FloorModel *filterFloorModel;//楼层筛选

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
    // Do any additional setup after loading the view from its nib.

    self.title = @"商户";
    
    
    [self.floorBtn addTarget:self action:@selector(floorBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.cateBtn addTarget:self action:@selector(categoryBtnAction:)
            forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.shopIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"pp_%d.jpg",indexPath.row+1]];
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"迪奥";
            cell.typeLabel.text = @"服饰";
            break;
        case 1:
            cell.titleLabel.text = @"杰克琼斯";
            cell.typeLabel.text = @"服饰";
            break;
        case 2:
            cell.titleLabel.text = @"可可尼";
            cell.typeLabel.text = @"服饰";
            break;
        case 3:
            cell.titleLabel.text = @"卡西欧";
            cell.typeLabel.text = @"配饰";
            break;
        case 4:
            cell.titleLabel.text = @"雷蛇";
            cell.typeLabel.text = @"配件";
            break;
        case 5:
            cell.titleLabel.text = @"万尼";
            cell.typeLabel.text = @"服饰";
            break;
        case 6:
            cell.titleLabel.text = @"Dickies";
            cell.typeLabel.text = @"服饰";
            break;
        case 7:
            cell.titleLabel.text = @"ENZO";
            cell.typeLabel.text = @"珠宝";
            break;
        default:
            break;
    }
    
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

@end
