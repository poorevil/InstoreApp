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

#import "YouHuiOrderViewController.h"

#import "StoreModel.h"
#import "FocusedStoreListInterface.h"
#import "StoreCategoryFilterViewController.h"

#import "FoodItemCell.h"

#import "FocusStoreInterface.h"

#import "StoreDetail_RestaurantViewController.h"

@interface StoreListFocusedViewController () <YouHuiOrderViewControllerDelegate,
FocusedStoreListInterfaceDelegate, StoreCategoryFilterViewControllerDelegate>

@property (nonatomic, retain) NSMutableArray *itemList;
@property (nonatomic, assign) NSInteger storeCount;

@property (nonatomic, retain) StoreListFocused_headerView *headerView;
@property (nonatomic,retain) NSString *filterCategory;//分类筛选条件
@property (nonatomic,retain) NSString *filterOrder;//排序

@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, retain) FocusedStoreListInterface *focusedStoreListInterface;

@property (retain, nonatomic) FocusStoreInterface *focusStoreInterface;

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
    self.itemList = [NSMutableArray array];
    
    [self initHeaderView];
    
    [self loadItemList];
    
    self.focusStoreInterface = [[[FocusStoreInterface alloc]init]autorelease];
    
    
    UIButton *btnEditor = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEditor.frame = CGRectMake(0, 0, 38, 19);
    [btnEditor setImage:[UIImage imageNamed:@"bankcard_editor.png"] forState:UIControlStateNormal];
    [btnEditor setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [btnEditor addTarget:self action:@selector(btnEditorAction:) forControlEvents:UIControlEventTouchUpInside];
    btnEditor.tag = 101;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btnEditor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [rightBtn release];
}

-(void)btnEditorAction:(UIButton *)sender{
    static BOOL isEditor = NO;
    if (isEditor == NO) {
        [sender setImage:nil forState:UIControlStateNormal];
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        
        isEditor = YES;
        self.mtableView.editing = YES;
        
        self.navigationItem.hidesBackButton = YES;
    }else{
        [sender setImage:[UIImage imageNamed:@"bankcard_editor.png"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        
        isEditor = NO;
        self.mtableView.editing = NO;
        self.navigationItem.hidesBackButton = NO;
    }
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
    self.focusStoreInterface = nil;
    self.headerView = nil;
    self.filterCategory = nil;
    self.filterOrder = nil;
    self.focusedStoreListInterface.delegate = nil;
    self.focusedStoreListInterface = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)loadItemList
{
    self.focusedStoreListInterface = [[[FocusedStoreListInterface alloc] init] autorelease];
    self.focusedStoreListInterface.delegate = self;
    [self.focusedStoreListInterface getFocusedStoreListByAmount:20
                                                           page:self.currentPage
                                                          order:self.filterOrder
                                                       category:self.filterCategory];
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
    StoreCategoryFilterViewController *scfvc = [[StoreCategoryFilterViewController alloc] initWithNibName:@"StoreCategoryFilterViewController" bundle:nil];
    scfvc.delegate = self;
    scfvc.category = self.filterCategory;
    scfvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scfvc animated:YES];
    scfvc.hidesBottomBarWhenPushed = NO;
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
    return self.itemList.count;
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
    
    FoodItemCell *fc = (FoodItemCell *)cell;
    fc.storeModel = [self.itemList objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreModel *storeModel = [self.itemList objectAtIndex:indexPath.row];
    
    StoreDetail_RestaurantViewController *sdrvc = [[StoreDetail_RestaurantViewController alloc] initWithNibName:@"StoreDetail_RestaurantViewController" bundle:nil];
    sdrvc.shopId = storeModel.sid;
    sdrvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sdrvc animated:YES];
    [sdrvc release];
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

#pragma mark - FocusedStoreListInterfaceDelegate <NSObject>
-(void)getFocusedStoreListDidFinished:(NSArray *)itemList
                           totalCount:(NSInteger)totalCount
                          currentPage:(NSInteger)currentPage
                           storeCount:(NSInteger)storeCount
{
    [self.itemList addObjectsFromArray:itemList];
    self.totalCount = totalCount;
    self.currentPage = currentPage;
    self.currentPage++;
    self.storeCount = storeCount;
    
    [self.mtableView reloadData];
}

-(void)getFocusedStoreListDidFailed:(NSString *)errorMsg
{
    NSLog(@"%@",errorMsg);
}

#pragma mark - StoreCategoryFilterViewControllerDelegate
-(void)categorySelectDidFinished:(NSString *) category name:(NSString *)name
{
    self.filterCategory = category;
    [self.headerView.categoryBtn setTitle:name forState:UIControlStateNormal];


    [self.itemList removeAllObjects];
    self.totalCount = 0;
    self.currentPage = 1;
    [self.mtableView reloadData];
    [self loadItemList];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        StoreModel *storeModel = [self.itemList objectAtIndex:indexPath.row];
        [self.focusStoreInterface focusStoreWithID:storeModel.sid WithMethod:@"DELETE"];
        
        [self.itemList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
