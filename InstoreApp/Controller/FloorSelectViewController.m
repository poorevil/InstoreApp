//
//  FloorSelectViewController.m
//  InstoreApp
//
//  Created by evil on 14-4-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FloorSelectViewController.h"
#import "FloorModel.h"
#import "FloorInterface.h"

@interface FloorSelectViewController () <UITableViewDataSource,UITableViewDelegate,FloorInterfaceDelegate>
@property (nonatomic,strong) UITableView *mtableView;
@property (nonatomic,strong) NSMutableArray *floors;//楼层列表
@property (nonatomic,strong) FloorModel *selectedFloorModel;

@property (nonatomic,strong) FloorInterface *floorInterface;
@end

@implementation FloorSelectViewController

-(id)initWithFloorModel:(FloorModel *)floorModel
{
    self = [super init];
    if (self) {
        self.selectedFloorModel = floorModel;
    }
    
    return self;
}

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
    // Do any additional setup after loading the view.
    self.title = @"楼层筛选";
    
    self.floors = [NSMutableArray array];
    
    self.mtableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.mtableView.delegate = self;
    self.mtableView.dataSource = self;
    
    [self.view addSubview:self.mtableView];
    
    self.floorInterface = [[FloorInterface alloc] init];
    self.floorInterface.delegate = self;
    //TODO:areaId暂时写死0
    [self.floorInterface getFloorListByAreaId:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.floors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    FloorModel *fm = [self.floors objectAtIndex:indexPath.row];
    cell.textLabel.text = [fm fName];
    
    if (self.selectedFloorModel.fid == fm.fid) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取选中的分类
    if ([self.delegate respondsToSelector:@selector(floorSelectDidFinished:)]) {
        [self.delegate floorSelectDidFinished:[self.floors objectAtIndex:indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - FloorInterfaceDelegate <NSObject>
-(void)getFloorListDidFinished:(NSArray *)floorList{
    [self.floors addObjectsFromArray:floorList];
    [self.mtableView reloadData];
}

-(void)getFloorListDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}


@end
