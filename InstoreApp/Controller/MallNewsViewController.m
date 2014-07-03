//
//  MallNewsViewController.m
//  InstoreApp
//
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsViewController.h"
#import "MallNewsModel.h"
#import "MallNewsInterface.h"
#import "MallNews_singleCell.h"
#import "MallNews_multiTableViewCell.h"
#import "MallNewsDetailViewController.h"
#import "WebViewController.h"

@interface MallNewsViewController () <MallNewsInterfaceDelegate>

@property (nonatomic, retain) NSMutableArray *itemList;
@property (nonatomic, retain) MallNewsInterface *mallNewsInterface;

@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation MallNewsViewController

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
    self.title = @"商场活动";
    self.itemList = [NSMutableArray array];
    
    self.mallNewsInterface = [[[MallNewsInterface alloc] init]autorelease];
    self.mallNewsInterface.delegate = self;
    [self.mallNewsInterface getMallNewsByPage:self.currentPage amount:20];
    
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
    self.mallNewsInterface.delegate = nil;
    self.mallNewsInterface = nil;
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.itemList objectAtIndex:indexPath.row];
    NSInteger template = [[dict objectForKey:@"template"] integerValue];//0: 单页格式； 1: **多图文**
    
    
    NSString *cellIdentifer = @"MallNews_singleCell";
    if (template == 1) {
        cellIdentifer = @"MallNews_multiTableViewCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifer
                                             owner:self
                                           options:nil] objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setDict:dict];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.itemList objectAtIndex:indexPath.row];
    NSInteger template = [[dict objectForKey:@"template"] integerValue];//0: 单页格式； 1: **多图文**
    
    
    NSInteger height = 310;
    if (template == 1) {
        height = 340;
    }
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [self.itemList objectAtIndex:indexPath.row];
    MallNewsModel *mnm = [[dict objectForKey:@"articles"] objectAtIndex:0];
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.urlStr = mnm.url;
    [self.navigationController pushViewController:webVC animated:YES];
    [webVC release];
}

#pragma mark - MallNewsInterfaceDelegate <NSObject>
-(void)getMallNewsDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage
{
    [self.itemList addObjectsFromArray:itemList];
    self.totalAmount = totalCount;
    self.currentPage = currentPage;
    self.currentPage++;
    
    [self.mtableView reloadData];
}

-(void)getmallNewsDidFailed:(NSString *)errorMsg
{
    NSLog(@"%@",errorMsg);
}
@end
