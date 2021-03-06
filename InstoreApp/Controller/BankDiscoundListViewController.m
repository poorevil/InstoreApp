//
//  BankDiscoundListViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BankDiscoundListViewController.h"
#import "BankDiscoundListCell.h"
#import "BankCardModel.h"
#import "BankCardDetailModel.h"
#import "BankCardDetailInterface.h"
#import "NSDate+DynamicDateString.h"

#import "MallNewsDetailViewController.h"

@interface BankDiscoundListViewController ()<BankCardDetailInterfaceDelegate>

@property (retain, nonatomic) BankCardDetailInterface *bankCardDetailInterface;
@property (nonatomic, retain) NSMutableArray *itemList;
@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, assign) NSInteger currentPage;
@property (assign, nonatomic) NSInteger everyPageCount;

@end

@implementation BankDiscoundListViewController

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
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 5)];
    view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.myTableView.tableHeaderView = view;
    [view release];
    
    self.itemList = [NSMutableArray array];
    self.bankCardDetailInterface = [[[BankCardDetailInterface alloc]init]autorelease];
    self.bankCardDetailInterface.delegate = self;
    self.currentPage = 1;
    self.everyPageCount = 10;
    [self.bankCardDetailInterface getBankCardDetailByPage:self.currentPage amount:self.everyPageCount andBankId:self.bankId];
    
    self.hidesBottomBarWhenPushed = YES;
    
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 238;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    BankDiscoundListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BankDiscoundListCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BankCardDetailModel *bankCardDetailModel = [self.itemList objectAtIndex:indexPath.row];
    cell.labTitle.text = bankCardDetailModel.title;
    cell.imgBankLogo.imageURL = [NSURL URLWithString:bankCardDetailModel.bank.logo];
    cell.imgView.imageURL = [NSURL URLWithString:bankCardDetailModel.image];
    cell.labStartTime.text = [[NSDate dateFromString:bankCardDetailModel.startTime] toDateString];
    cell.labEndTime.text = [[NSDate dateFromString:bankCardDetailModel.endTime] toDateString];    
    cell.imageStoreLogo.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/100*100.png",bankCardDetailModel.store.logoUrl]];
    
    if (indexPath.row == self.itemList.count - 1) {
        if (self.currentPage * self.everyPageCount < self.totalAmount) {
            self.currentPage++;
            [self.bankCardDetailInterface getBankCardDetailByPage:self.currentPage amount:self.everyPageCount andBankId:self.bankId];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MallNewsDetailViewController *detailVC = [[MallNewsDetailViewController alloc]init];
    BankCardDetailModel *bankCardDetailModel = [self.itemList objectAtIndex:indexPath.row];
    detailVC.youhuiID = bankCardDetailModel.youHuiId;
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

#pragma mark - BankCardDetailInterfaceDelegate
-(void)getBankCardDetailDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    [self.itemList addObjectsFromArray:itemList];
    self.totalAmount = totalCount;
    
    [self.myTableView reloadData];
}
-(void)getBankCardDetailDidFailed:(NSString *)errorMsg{
    DebugLog(@"%@",errorMsg);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.itemList = nil;
    self.bankCardDetailInterface.delegate = nil;
    self.bankCardDetailInterface = nil;
    [_myTableView release];
    [super dealloc];
}
@end
