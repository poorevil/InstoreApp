//
//  MyFocusYouHuiViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyFocusYouHuiViewController.h"
#import "MyFocusYouHuiInterface.h"
#import "CouponModel.h"
#import "CouponView_focusedCell.h"

@interface MyFocusYouHuiViewController ()<MyFocusYouHuiInterfaceDelegate>

@property (retain, nonatomic) MyFocusYouHuiInterface *myFocusYouHuiInterface;
@property (retain, nonatomic) NSMutableArray *itemList;
@property (assign, nonatomic) NSInteger totalCount;
@property (assign, nonatomic) NSInteger currentPage;


@end

@implementation MyFocusYouHuiViewController

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
    self.title = @"我收藏的优惠";
    self.currentPage = 1;
    
    self.myFocusYouHuiInterface = [[MyFocusYouHuiInterface alloc]init];
    self.myFocusYouHuiInterface.delegate = self;
    [self.myFocusYouHuiInterface getMyFocusYouHuiListWithAmount:20 Page:self.currentPage];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 236;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ceil(self.itemList.count / 2.0);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CouponView_focusedCell";
    CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
        cell.addSecondView = YES;
    }
    cell.cm1 = [self.itemList objectAtIndex:indexPath.row * 2];
    if (self.itemList.count == indexPath.row * 2 +1) {
        cell.cm2 = nil;
    }else{
        cell.cm2 = [self.itemList objectAtIndex:(indexPath.row * 2 + 1)];
    }
    return cell;
}

#pragma mark - MyFocusYouHuiInterfaceDelegate <NSObject>
-(void)getMyFocusYouHuiListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    [self.itemList addObjectsFromArray:itemList];
    self.totalCount = totalCount;
    self.currentPage = currentPage;
    self.currentPage++;
    
    [self.myTableView reloadData];
}
-(void)getMyFocusYouHuiListDidFailed:(NSString *)errorMsg{
    NSLog(@"%@",errorMsg);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    self.itemList = nil;
    [super dealloc];
}
@end
