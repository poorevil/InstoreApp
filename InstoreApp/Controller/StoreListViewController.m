//
//  StoreListViewController.m
//  InstoreApp
//
//  Created by evil on 14-6-24.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreListViewController.h"

#import "StoreList_headerView.h"
#import "StoreInterface.h"

#import "StoreList_goodsCell.h"
#import "FoodItemCell.h"

@interface StoreListViewController () <UITableViewDataSource, UITableViewDelegate,
StoreInterfaceDelegate>

@property (nonatomic, assign) NSInteger storeCount;

@property (nonatomic, retain) StoreList_headerView *headerView;
//百货
@property (nonatomic, retain) NSMutableArray *goodsItemList;
@property (nonatomic, assign) NSInteger goodsTotalCount;
@property (nonatomic, assign) NSInteger goodsCurrentPage;

//餐饮
@property (nonatomic, retain) NSMutableArray *foodItemList;
@property (nonatomic, assign) NSInteger foodTotalCount;
@property (nonatomic, assign) NSInteger foodCurrentPage;

//娱乐
@property (nonatomic, retain) NSMutableArray *gameItemList;
@property (nonatomic, assign) NSInteger gameTotalCount;
@property (nonatomic, assign) NSInteger gameCurrentPage;

@property (nonatomic, retain) StoreInterface *storeInterface;

@end

@implementation StoreListViewController

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
    self.goodsItemList = [NSMutableArray array];
    self.foodItemList = [NSMutableArray array];
    self.gameItemList = [NSMutableArray array];
    
    [self initHeaderView];
    
    [self loadItemList];
}

-(void)loadItemList
{
    NSString *category = nil;
    NSInteger page = 1;
    
    switch (self.headerView.segmentControl.selectedSegmentIndex) {
        case 0:
            category = @"Department";
            page = self.goodsCurrentPage;
            break;
        //TODO:
        case 1:
            category = @"Department";
            page = self.foodCurrentPage;
            break;
        case 2:
            category = @"Food";//TODO:11
            page = self.foodCurrentPage;
            break;
        default:
            category = @"Game";//TODO:11
            page = self.goodsCurrentPage;
            break;
    }
    
    self.storeInterface = [[StoreInterface alloc] init];
    self.storeInterface.delegate = self;
    [self.storeInterface getStoreListByAmount:20 page:page category:category];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mtableView = nil;
    self.headerView = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)initHeaderView
{
    if (!self.headerView) {
        self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"StoreList_headerView"
                                                        owner:self
                                                       options:nil] objectAtIndex:0];
        
        self.mtableView.tableHeaderView = self.headerView;
        [self.headerView.segmentControl addTarget:self
                                           action:@selector(segmentChanged:)
                                 forControlEvents:UIControlEventValueChanged];
    }
}

-(void)segmentChanged:(id)sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
            if (self.goodsItemList.count==0) {
                [self loadItemList];
            }
            return;
        case 1:
            if (self.foodItemList.count==0) {
                [self loadItemList];
            }
            return;
        case 2:
            if (self.gameItemList.count==0) {
                [self loadItemList];
            }
            return;
        default:
            break;
    }
    
    [self.mtableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.headerView.segmentControl.selectedSegmentIndex) {
        case 0:
            return self.goodsItemList.count;
        case 1:
            return self.foodItemList.count;
        case 2:
            return self.gameItemList.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = nil;
    //TODO:判断
    switch (self.headerView.segmentControl.selectedSegmentIndex) {
        case 0:
            cellIdentifer = @"StoreList_goodsCell";
            break;
        case 1:
            cellIdentifer = @"FoodItemCell";
            break;
        case 2:
            cellIdentifer = @"StoreList_goodsCell";
            break;
        default:
            cellIdentifer = @"StoreList_goodsCell";
            break;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifer
                                             owner:self
                                            options:nil] objectAtIndex:0];
    }
    
    if ([cell isMemberOfClass:[StoreList_goodsCell class]]) {
        StoreList_goodsCell *goodsCell = (StoreList_goodsCell *)cell;
        goodsCell.storeModel = [self.goodsItemList objectAtIndex:indexPath.row];
    }else if ([cell isMemberOfClass:[FoodItemCell class]]){
        FoodItemCell *foodCell = (FoodItemCell *)cell;
        foodCell.storeModel = [self.goodsItemList objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.headerView.segmentControl.selectedSegmentIndex) {
        case 0:
            return 63;
        case 1:
            return 80;
        case 2:
            return 63;
        default:
            return 63;
    }
}

#pragma mark - StoreInterfaceDelegate <NSObject>

-(void)getStoreListDidFinished:(NSArray *)resultList
                    totalCount:(NSInteger)totalCount
                    storeCount:(NSInteger)storeCount    //用户关注的商家数
                   currentPage:(NSInteger)currentPage
                      category:(NSString *)category
{
    if ([category isEqualToString:@"Department"]) {
        [self.goodsItemList addObjectsFromArray:resultList];
        self.goodsTotalCount = totalCount;
        self.goodsCurrentPage = currentPage;
        self.goodsCurrentPage++;
    }
    //TODO:else
    
    self.storeCount = storeCount;
    
    [self.mtableView reloadData];
}

-(void)getStoreListDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

@end
