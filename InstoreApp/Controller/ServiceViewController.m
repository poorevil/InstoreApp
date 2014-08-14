//
//  ServiceViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceViewCell.h"
#import "ServiceModel.h"
#import "ServicesInterface.h"

@interface ServiceViewController () <UITableViewDataSource,UITableViewDelegate,ServicesInterfaceDelegate>

@property (nonatomic,strong) UITableView *mtableView;

@property (nonatomic,strong) ServicesInterface *servicesInterface;
@property (nonatomic,strong) NSMutableArray *serviceList;
@end

@implementation ServiceViewController

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
    
    self.title = @"服务";
    self.serviceList = [NSMutableArray array];
    
    self.mtableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
                                                                self.view.bounds.size.height)] autorelease];
    self.mtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mtableView.allowsSelection = NO;
    self.mtableView.delegate = self;
    self.mtableView.dataSource = self;
    
    [self.view addSubview:self.mtableView];
    
    UIView *tableViewFooterView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                           self.view.bounds.size.width,
                                                                           100)] autorelease];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                               self.view.bounds.size.width, 100)] autorelease];
    label.text = @"更多精彩应用，敬请期待";
    label.textAlignment = NSTextAlignmentCenter;
    [tableViewFooterView addSubview:label];
    self.mtableView.tableFooterView = tableViewFooterView;
    
    self.servicesInterface = [[[ServicesInterface alloc] init] autorelease];
    self.servicesInterface.delegate = self;
    [self.servicesInterface getServicesList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    cell.serviceList = self.serviceList;
    
    return  cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"本地生活";
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

#pragma mark - ServicesInterfaceDelegate <NSObject>
-(void)getServicesListDidFinished:(NSArray *)resultList totalCount:(NSInteger)totalCount
{
    [self.serviceList addObjectsFromArray:resultList];
    
    [self.mtableView reloadData];
}

-(void)getServicesListDidFailed:(NSString *)errorMessage
{
    DebugLog(@"%@",errorMessage);
}

-(void)dealloc
{
    self.mtableView = nil;
    self.servicesInterface.delegate = nil;
    self.servicesInterface = nil;
    self.serviceList = nil;
    
    [super dealloc];
}

@end
