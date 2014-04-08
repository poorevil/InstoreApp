//
//  ShopDetailViewController.m
//  InstoreApp
//
//  Created by hanchao on 14-4-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ShopDetailHeaderView.h"
#import "ShopDetailLocationCell.h"
#import "ShopDetailItemListCell.h"

@interface ShopDetailViewController ()

@property (nonatomic,strong) ShopDetailHeaderView *headerView;

@end

@implementation ShopDetailViewController

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
    
    [self initHeaderView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(void)initHeaderView
{
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"ShopDetailHeaderView" owner:self options:nil] objectAtIndex:0];
    
    self.mtableView.tableHeaderView = self.headerView;
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    switch (section) {
//        case 0:
//            return 1;
//        case 1:
//            return 2;
//        case 2:
//            return 3;
//        case 3:
//            return 1;
//            
//        default:
//            return 1;
//    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    
    switch (indexPath.section) {
        case 0:
            cellIdentifier = @"ShopDetailTypeCell";
            break;
        case 1:
            cellIdentifier = @"ShopDetailLocationCell";
            break;
        case 2:
            cellIdentifier = @"ShopDetailItemListCell";
            break;
//        case 2:
//            cell.textLabel.text = @"品类列表";
//            break;
//        case 3:
//            cell.textLabel.text = @"店铺描述";
//            break;
//        case 4:
//            cell.textLabel.text = @"品论列表";
//            break;
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier
                                             owner:self
                                           options:nil] objectAtIndex:0];
    }
    
//    switch (indexPath.section) {
//        case 0:
//            cell.textLabel.text = @"餐饮    人均：￥50";
//            break;
//        case 1:
//            cell.textLabel.text = @"010-8634294";
//            break;
//        case 2:
//            cell.textLabel.text = @"品类列表";
//            break;
//        case 3:
//            cell.textLabel.text = @"店铺描述";
//            break;
//        case 4:
//            cell.textLabel.text = @"品论列表";
//            break;
//        default:
//            break;
//    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        case 1:
            return 44;
        case 2:
            return 95;
//        case 3:
//            cell.textLabel.text = @"店铺描述";
//            break;
//        case 4:
//            cell.textLabel.text = @"品论列表";
//            break;
        default:
            return 44;
    }
}
@end
