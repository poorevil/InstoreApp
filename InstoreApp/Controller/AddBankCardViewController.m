//
//  AddBankCardViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "EGOImageView.h"
#import "AddBankCardCell.h"
#import "AddBankCardModel.h"
#import "SaveAddBankCardInterface.h"

#import "BankCardViewController.h"

@interface AddBankCardViewController ()<SaveAddBankCardInterfaceDelegate>{
    SaveAddBankCardInterface *saveVC;
}

@end

@implementation AddBankCardViewController

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
    self.chooeseBankCard = [NSMutableDictionary dictionary];
    
    saveVC = [[SaveAddBankCardInterface alloc]init];
    saveVC.delegate = self;
    self.currentPage = 1;
    
    self.addBankCardInterface = [[[AddBandCardInterface alloc]init]autorelease];
    _addBankCardInterface.delegate = self;
    [_addBankCardInterface getAddBankCardByPage:self.currentPage amount:20];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    label.text = @"  请选择银行";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithRed:121/255.0 green:121/255.0 blue:121/255.0 alpha:1];
    self.myTableView.tableHeaderView = label;
    [label release];
    
    self.hidesBottomBarWhenPushed = YES;
    
}
#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifer = @"Cell";
    AddBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddBankCardCell"
                                              owner:self
                                            options:nil] objectAtIndex:0];
    }
    if (self.itemList.count > 0) {
        AddBankCardModel *addBankModel = [self.itemList objectAtIndex:indexPath.row];
        cell.egoImageView.imageURL = [NSURL URLWithString:addBankModel.logo];
        cell.labBankName.text = addBankModel.name;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    AddBankCardModel *addBankModel = [self.itemList objectAtIndex:indexPath.row];
    BOOL chooesed = addBankModel.choosed;
    
    if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        if (chooesed == NO) {
            NSInteger bankId = addBankModel.bankId;
            [self.chooeseBankCard setObject:[NSNumber numberWithInteger:bankId] forKey:[NSString stringWithFormat:@"%d",bankId]];
            self.chooesedCount++;
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        if ([self.chooeseBankCard objectForKey:[NSString stringWithFormat:@"%d",addBankModel.bankId]]) {
            [self.chooeseBankCard removeObjectForKey:[NSString stringWithFormat:@"%d",addBankModel.bankId]];
            self.chooesedCount--;
        }
    }
    
}

-(void)getAddBankCardDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    
    for (AddBankCardModel *addBankCardModel in itemList) {
        BOOL chooesed = addBankCardModel.choosed;
        if (chooesed == NO) {
            [self.itemList addObject:addBankCardModel];
        }
    }
//    [self.itemList addObjectsFromArray:itemList];
    self.totalAmount = totalCount;
//    self.currentPage = currentPage;
    self.currentPage++;
    
    [self.myTableView reloadData];
}
-(void)getAddBankCardDidFailed:(NSString *)errorMsg{
    NSLog(@"%s:%@",__FUNCTION__,errorMsg);
}
-(void)dealloc{
    self.addBankCardInterface.delegate = nil;
    self.addBankCardInterface = nil;
    self.itemList = nil;
    self.chooeseBankCard = nil;
    [saveVC release];
    
    [_myTableView release];
    [_labChooeseCount release];
    [_labText release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setChooesedCount:(int)chooesedCount{
    _chooesedCount = chooesedCount;
    self.labChooeseCount.text = [NSString stringWithFormat:@"%d",chooesedCount];
}
- (IBAction)btnFinishedAction:(UIButton *)sender {
    if (self.chooeseBankCard.count > 0) {
        [saveVC SaveAddBankCardWithDictionary:self.chooeseBankCard];
    }
    
}
-(void)getReceivedFromPoatAddBankCard:(NSString *)result{
    if ([result isEqualToString:@"success"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"保存成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 100;
        [alert show];
        [alert release];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"保存失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        NSArray *array = self.navigationController.viewControllers;
        UIViewController *vcc = nil;
        for (UIViewController *vc in array) {
            if ([[vc class] isSubclassOfClass:[BankCardViewController class]]) {
                vcc = vc;
            }
        }        
        [self.navigationController popViewControllerAnimated:YES];
        [(BankCardViewController *)vcc refreshData];
    }
}
@end
