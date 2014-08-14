//
//  FocusStoreViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusStoreViewController.h"
//#import "FocusStoreInterface.h"
#import "FocusStoreListInterface.h"
#import "FocusStoreModel.h"
#import "FocusStoreCell.h"

#import "CategoryOrderViewController.h"

#import "SetStoreFocusRecommend.h"

@interface FocusStoreViewController ()<FocusStoreListInterfaceDelegate,UpDateFocusStoreCountDelegate,CategoryOrderViewControllerHaveSelectedCategoryDelegate>

//@property (retain, nonatomic) FocusStoreInterface *focusStoreInterface;

@property (retain, nonatomic) FocusStoreListInterface *focusStoreListInterface;
@property (retain, nonatomic) NSMutableArray *itemList;
@property (assign, nonatomic) NSInteger totalCount;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger everyPageCount;
@property (assign, nonatomic) NSInteger storeCount;
@property (assign, nonatomic) BOOL recommend;

@property (retain, nonatomic) SetStoreFocusRecommend *setStoreFocusRecommend;

@end

@implementation FocusStoreViewController


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
    
    self.title = [NSString stringWithFormat:@"选择喜欢的品牌(%d)",self.storeCount];
    self.itemList = [NSMutableArray array];
    self.currentPage = 1;
    self.everyPageCount = 10;
    
    self.focusStoreListInterface = [[[FocusStoreListInterface alloc]init]autorelease];
    self.focusStoreListInterface.delegate = self;
    [self.focusStoreListInterface getFocusStoreListWithAmout:self.everyPageCount Page:self.currentPage Caregory:nil];
    
    self.setStoreFocusRecommend = [[[SetStoreFocusRecommend alloc]init]autorelease];
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ceil(self.itemList.count / 4.0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FocusStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FocusStoreCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.view1 = [self.itemList objectAtIndex:indexPath.row * 4];
    if ((indexPath.row * 4 + 1) < self.itemList.count) {
        cell.view2 = [self.itemList objectAtIndex:(indexPath.row * 4 + 1)];
    }
    if ((indexPath.row * 4 + 2) < self.itemList.count) {
        cell.view3 = [self.itemList objectAtIndex:(indexPath.row * 4 + 2)];
    }
    if ((indexPath.row * 4 + 3) < self.itemList.count) {
        cell.view4 = [self.itemList objectAtIndex:(indexPath.row * 4 + 3)];
    }
    
    if (indexPath.row == ceil(self.itemList.count / 4.0) - 1) {
        if (self.currentPage * self.everyPageCount < self.totalCount) {
            self.currentPage++;
            [self.focusStoreListInterface getFocusStoreListWithAmout:self.everyPageCount Page:self.currentPage Caregory:nil];
        }
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)setStoreCount:(NSInteger)storeCount{
    if (_storeCount != storeCount) {
        _storeCount = storeCount;
        self.title = [NSString stringWithFormat:@"选择喜欢的品牌(%d)",storeCount];
    }
}

#pragma mark - FocusStoreListInterfaceDelegate
-(void)getFocusStoreListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage storeCount:(NSInteger)storeCount recommend:(BOOL)recommend{
    [self.itemList addObjectsFromArray:itemList];
    self.totalCount = totalCount;
    self.storeCount = storeCount;
    self.recommend = recommend;
    
    [self.myTableView reloadData];
}
-(void)getFocusStoreListDidFailed:(NSString *)errorMsg{
    DebugLog(@"%s:%@",__FUNCTION__,errorMsg);
}

#pragma mark - UpDateFocusStoreCountDelegate
-(void)upDataFocusStoreCount:(BOOL)isAddOrDelete{
    if (isAddOrDelete) {
        self.storeCount++;
    }else{
        self.storeCount--;
    }
}

#pragma mark - CategoryOrderViewControllerHaveSelectedCategoryDelegate <NSObject>
-(void)categoryOrderViewControllerHaveSelectedCategory:(NSString *)result{
    [self.btnCategory setTitle:result forState:UIControlStateNormal];
    NSString *category = @"";
    if ([result isEqualToString:@"餐饮"]) {
        category = @"Restaurant";
    }else if([result isEqualToString:@"娱乐"]){
        category = @"Entertainment";
    }else{
        category = @"Department";
    }
    
    self.currentPage = 1;
    [self.itemList removeAllObjects];
    [self.focusStoreListInterface getFocusStoreListWithAmout:20 Page:self.currentPage Caregory:category];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_btnIsRecommend release];
    [_myTableView release];
    self.focusStoreListInterface = nil;
//    self.focusStoreInterface = nil;
    self.itemList = nil;
    
    [_btnCategory release];
    [super dealloc];
}
- (IBAction)btnIsRecommendAction:(UIButton *)sender {
    if (_recommend) {
        [self.btnIsRecommend setImage:[UIImage imageNamed:@"focusstore_no.png"] forState:UIControlStateNormal];
        [self.setStoreFocusRecommend setStoreFocusRecomend:NO];
        _recommend = NO;
    }else{
        [self.btnIsRecommend setImage:[UIImage imageNamed:@"focusstore_yes.png"] forState:UIControlStateNormal];
        [self.setStoreFocusRecommend setStoreFocusRecomend:YES];
        _recommend = YES;
    }
}
- (IBAction)btnCategoryAction:(UIButton *)sender {
    CategoryOrderViewController *vc = [[CategoryOrderViewController alloc]initWithNibName:@"CategoryOrderViewController" bundle:nil];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.list = @[@"全部分类",@"百货",@"餐饮",@"娱乐"];
    vc.nowSelectedString = sender.titleLabel.text;
    [vc release];
}
-(void)setRecommend:(BOOL)recommend{
    _recommend = recommend;
    if (recommend) {
        [self.btnIsRecommend setImage:[UIImage imageNamed:@"focusstore_yes.png"] forState:UIControlStateNormal];
    }else{
        [self.btnIsRecommend setImage:[UIImage imageNamed:@"focusstore_no.png"] forState:UIControlStateNormal];
    }
}
@end
