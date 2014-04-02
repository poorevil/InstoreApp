//
//  CouponDetailViewController.m
//  InstoreApp
//
//  Created by hanchao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDetailViewController.h"

@interface CouponDetailViewController ()
@property (nonatomic,strong) UIView *headerView;
@end

@implementation CouponDetailViewController

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
//初始化头部view
-(void)initHeaderView
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"coffee.jpg"]];
    headerImageView.frame = CGRectMake(10, 10, 300, 300);
    [self.headerView addSubview:headerImageView];
    
    UIView *titleGroupView = [[UIView alloc] initWithFrame:CGRectMake(10, 320-34, 300, 34)];
    titleGroupView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 28)];
    titleLabel.text = @"俏江南红烧肉全场8折";
    titleLabel.textColor = [UIColor whiteColor];
    [titleGroupView addSubview:titleLabel];
    
    [self.headerView addSubview:titleGroupView];
    self.mtableView.tableHeaderView = self.headerView;
    
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        case 2:
            return 3;
        case 3:
            return 1;
            
        default:
            return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"已下载：29234次";
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"有效期";
                    break;
                case 1:
                    cell.textLabel.text = @"03月15日至08月13日";
                    break;
                default:
                    break;
            }
            
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"商户：俏江南";
                    break;
                case 1:
                    cell.textLabel.text = @"地址：4F/108";
                    break;
                case 2:
                    cell.textLabel.text = @"电话：010-32324345";
                    break;
                default:
                    break;
            }
            break;
        case 3:
            cell.textLabel.text = @"优惠劵详情";
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    switch (indexPath.section) {
//        case 0:
//            return 130;
//        case 1:
//            return 180;
//        case 2:
//            return 334;
//            //        case 3:
//            //            cellIdentifier = @"MainViewOtherCell";
//            //            break;
//            //        case 4:
//            //            cellIdentifier = @"MainViewSliderCell";
//            //            break;
//            //        case 5:
//            //            cellIdentifier = @"MainViewSliderCell";
//            //            break;
//            //        case 6:
//            //            cellIdentifier = @"MainViewSliderCell";
//            //            break;
//            
//        default:
//            return 310;
//            break;
//    }
//    
//}

@end
