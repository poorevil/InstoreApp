//
//  FocusStoreViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusStoreViewController.h"
#import "FocusStoreInterface.h"
#import "FocusStoreListInterface.h"
#import "FocusStoreModel.h"
#import "FocusStoreCell.h"

@interface FocusStoreViewController ()<FocusStoreListInterfaceDelegate>

@property (retain, nonatomic) FocusStoreInterface *focusStoreInterface;

@property (retain, nonatomic) FocusStoreListInterface *focusStoreListInterface;
@property (retain, nonatomic) NSMutableArray *itemList;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger storeCount;
//@property

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
-(void)awakeFromNib{
    //
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = [NSString stringWithFormat:@"选择喜欢的品牌(%d)",self.storeCount];
    self.itemList = [NSMutableArray array];
    self.currentPage = 1;
    
    self.focusStoreListInterface = [[[FocusStoreListInterface alloc]init]autorelease];
    self.focusStoreListInterface.delegate = self;
    [self.focusStoreListInterface getFocusStoreListWithAmout:20 Page:self.currentPage Caregory:nil];
    
    self.focusStoreInterface = [[[FocusStoreInterface alloc]init]autorelease];
    
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceil(self.itemList.count / 4.0);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FocusStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FocusStoreCell" owner:self options:nil] lastObject];
    }
    cell.view1 = [self.itemList objectAtIndex:indexPath.row * 4];
    if ((indexPath.row * 4 + 1) <= self.itemList.count) {
        cell.view2 = [self.itemList objectAtIndex:(indexPath.row * 4 + 1)];
    }
    if ((indexPath.row * 4 + 2) <= self.itemList.count) {
        cell.view3 = [self.itemList objectAtIndex:(indexPath.row * 4 + 2)];
    }
    if ((indexPath.row * 4 + 3) <= self.itemList.count) {
        cell.view4 = [self.itemList objectAtIndex:(indexPath.row * 4 + 3)];
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - FocusStoreListInterfaceDelegate
-(void)getFocusStoreListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage storeCount:(NSInteger)storeCount recommend:(NSString *)recommend{
    [self.itemList addObjectsFromArray:itemList];
    self.currentPage = currentPage;
    self.currentPage++;
    self.storeCount = storeCount;
//    self.recommend = recommend;
    
    [self.myTableView reloadData];
}
-(void)getFocusStoreListDidFailed:(NSString *)errorMsg{
    NSLog(@"%s:%@",__FUNCTION__,errorMsg);
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
    self.focusStoreInterface = nil;
    self.itemList = nil;
    
    [super dealloc];
}
- (IBAction)btnIsRecommendAction:(UIButton *)sender {
//    [sender setImage:[UIImage imageNamed:@"focusstore_yes.png"] forState:UIControlStateNormal];
}
@end
