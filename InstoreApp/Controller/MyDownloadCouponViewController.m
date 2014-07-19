//
//  MyDownloadCouponViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyDownloadCouponViewController.h"
#import "MyDownloadCouponInterface.h"
#import "DownloadCouponModel.h"
#import "MyDownloadCoumonCell.h"

#import "DownloadCouponDetailViewController.h"

@interface MyDownloadCouponViewController ()<MyDownloadCouponInterfaceDelegate>

@property (retain, nonatomic) NSMutableArray *itemList;

@property (retain, nonatomic) MyDownloadCouponInterface *myDownloadCouponInterface;

@end

@implementation MyDownloadCouponViewController

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
    
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"我的优惠券";
    self.itemList = [NSMutableArray array];
    
    self.myDownloadCouponInterface = [[[MyDownloadCouponInterface alloc]init]autorelease];
    self.myDownloadCouponInterface.delegate = self;
    [self.myDownloadCouponInterface getMyDownloadCouponList];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    MyDownloadCoumonCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyDownloadCoumonCell" owner:self options:nil] objectAtIndex:0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.couponModel = [self.itemList objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DownloadCouponDetailViewController *vc = [[DownloadCouponDetailViewController alloc]initWithNibName:@"DownloadCouponDetailViewController" bundle:nil];
    DownloadCouponModel *model = [self.itemList objectAtIndex:indexPath.row];
//    vc.couponModel.cid = model.cid;
    vc.cid = model.cid;
    vc.downloadCouponModel = model;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark - MyDownloadCouponInterfaceDelegate
-(void)getMyDownloadCouponListDidFinished:(NSArray *)array{
    [self.itemList addObjectsFromArray:array];
    
    [self.myTableView reloadData];
}
-(void)getMyDownloadCouponListDidFailed:(NSString *)errorMsg{
    NSLog(@"%@",errorMsg);
}

-(void)dealloc{
    self.itemList = nil;
    self.myDownloadCouponInterface = nil;
    
    [_myTableView release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
