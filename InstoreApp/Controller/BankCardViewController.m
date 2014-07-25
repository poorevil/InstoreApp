//
//  BankCardViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BankCardViewController.h"
#import "BankCardCell.h"
#import "BankCardInterface.h"
#import "BankCardModel.h"
#import "BankDiscoundListViewController.h"
#import "AddBankCardViewController.h"
#import "DeleteBankCardInterface.h"


@interface BankCardViewController ()<BankCardInterfaceDelegate>{
    UIButton *btnTemp;
}

@property (retain, nonatomic) BankCardInterface *bankCardInterface;
@property (nonatomic, retain) NSMutableArray *itemList;
@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, assign) NSInteger currentPage;
@property (retain, nonatomic) DeleteBankCardInterface *deleteBankCardInterface;

@end

@implementation BankCardViewController

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
    
    self.itemList = [NSMutableArray array];
    self.title = @"银行卡恵";
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.rightBarButtonItem = nil;
    
    UIButton *btnEditor = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEditor.frame = CGRectMake(0, 0, 38, 19);
    [btnEditor setImage:[UIImage imageNamed:@"bankcard_editor.png"] forState:UIControlStateNormal];
    [btnEditor setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [btnEditor addTarget:self action:@selector(btnEditorAction:) forControlEvents:UIControlEventTouchUpInside];
    btnEditor.tag = 101;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btnEditor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [rightBtn release];
    
    self.bankCardInterface = [[[BankCardInterface alloc]init]autorelease];
    _bankCardInterface.delegate = self;
    [_bankCardInterface getBankCardByPage:self.currentPage amount:20];
    
    self.deleteBankCardInterface = [[[DeleteBankCardInterface alloc]init]autorelease];
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 94)];
    UIButton *btnAddBank = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAddBank.frame = CGRectMake(15, 30, 290, 34);
    [btnAddBank setImage:[UIImage imageNamed:@"bankcard_addBank.png"] forState:UIControlStateNormal];
    [btnAddBank addTarget:self action:@selector(btnAddBankAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnAddBank];
    self.myTableView.tableFooterView = footView;
    [footView release];
}

-(void)refreshData{
    self.currentPage = 1;
    [self.itemList removeAllObjects];
    [_bankCardInterface getBankCardByPage:self.currentPage amount:20];
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BankCardCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    BankCardModel *bankCardModel = [self.itemList objectAtIndex:indexPath.row];
    cell.labBankName.text = bankCardModel.name;
    cell.labSlogan.text = bankCardModel.slogan;
    cell.labDiscountCount.text = [NSString stringWithFormat:@"(%d个优惠)",bankCardModel.promotionCount];
    cell.bankImageIcon.imageURL = [NSURL URLWithString:bankCardModel.logo];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BankDiscoundListViewController *bankDiscoundListVC = [[BankDiscoundListViewController alloc]init];
    BankCardModel *bankCardModel = [self.itemList objectAtIndex:indexPath.row];
    bankDiscoundListVC.title = bankCardModel.name;
    bankDiscoundListVC.bankId = bankCardModel.bankId;
    [self.navigationController pushViewController:bankDiscoundListVC animated:YES];
    [bankDiscoundListVC release];
//    [bankCardModel release];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BankCardModel *bankCardModel = [self.itemList objectAtIndex:indexPath.row];
        NSInteger bankId = bankCardModel.bankId;
        [self.deleteBankCardInterface deleteBankCardWithBankId:bankId];        
        
        [self.itemList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];    
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"  删除";
}

-(void)btnEditorAction:(UIButton *)sender{
    static BOOL isEditor = NO;
    if (isEditor == NO) {
        [sender setImage:nil forState:UIControlStateNormal];
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        
        isEditor = YES;
        self.myTableView.editing = YES;
        
        self.navigationItem.hidesBackButton = YES;
    }else{
        [sender setImage:[UIImage imageNamed:@"bankcard_editor.png"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        
        isEditor = NO;
        self.myTableView.editing = NO;
        self.navigationItem.hidesBackButton = NO;
    }
    if (!btnTemp) {
        btnTemp = sender;
    }    
}

-(void)getBankCardDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    [self.itemList addObjectsFromArray:itemList];
    self.totalAmount = totalCount;
    self.currentPage = currentPage;
    self.currentPage++;
    
    [self.myTableView reloadData];
}
-(void)getBankCardDidFailed:(NSString *)errorMsg{
    NSLog(@"%s:%@",__FUNCTION__,errorMsg);
}
-(void)btnAddBankAction:(UIButton *)sender{
    if (self.myTableView.editing == YES) {
        self.myTableView.editing = NO;
        [btnTemp setImage:[UIImage imageNamed:@"bankcard_editor.png"] forState:UIControlStateNormal];
        [btnTemp setTitle:@"" forState:UIControlStateNormal];
    }
    
    AddBankCardViewController *addBankCardVC = [[AddBankCardViewController alloc]init];
    [self.navigationController pushViewController:addBankCardVC animated:YES];
    addBankCardVC.title = @"添加银行卡";
    [addBankCardVC release];
}
-(void)dealloc{
    self.bankCardInterface.delegate = nil;
    self.bankCardInterface = nil;
    self.deleteBankCardInterface = nil;
    
    [_myTableView release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
