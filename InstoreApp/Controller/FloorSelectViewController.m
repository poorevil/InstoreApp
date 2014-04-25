//
//  FloorSelectViewController.m
//  InstoreApp
//
//  Created by evil on 14-4-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FloorSelectViewController.h"
#import "FloorModel.h"

@interface FloorSelectViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *mtableView;
@property (nonatomic,strong) NSMutableArray *floors;//楼层列表
@property (nonatomic,strong) FloorModel *selectedFloorModel;
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
    
    for (NSInteger i=0; i<5; i++) {
        FloorModel *floorModel = [[FloorModel alloc] init];
        floorModel.fid = [NSString stringWithFormat:@"%d",i];
        floorModel.fName = [NSString stringWithFormat:@"%d层",i+1];
        [self.floors addObject:floorModel];
    }
    
    
    self.mtableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.mtableView.delegate = self;
    self.mtableView.dataSource = self;
    
    
    [self.view addSubview:self.mtableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    
    if ([self.selectedFloorModel.fid isEqualToString:fm.fid]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO:获取选中的分类
    //TODO:更新selectedCategory
    if ([self.delegate respondsToSelector:@selector(floorSelectDidFinished:)]) {
        [self.delegate floorSelectDidFinished:[self.floors objectAtIndex:indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
