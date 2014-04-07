//
//  ShopViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopViewCell.h"
#import "ShopDetailViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

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

    self.title = @"商户";
    
    UIImage *originalImage = [UIImage imageNamed:@"top-search-icon"];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 10, 300);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    [self.floorBtn setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    [self.floorBtn setBackgroundImage:stretchableImage forState:UIControlStateHighlighted];
    [self.floorBtn setBackgroundImage:stretchableImage forState:UIControlStateSelected];
    
    [self.cateBtn setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    [self.cateBtn setBackgroundImage:stretchableImage forState:UIControlStateHighlighted];
    [self.cateBtn setBackgroundImage:stretchableImage forState:UIControlStateSelected];
    
    [self.sortBtn setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    [self.sortBtn setBackgroundImage:stretchableImage forState:UIControlStateHighlighted];
    [self.sortBtn setBackgroundImage:stretchableImage forState:UIControlStateSelected];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    
    return  cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShopDetailViewController *shopDetailVC = [[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController"
                                                                                        bundle:nil];
    shopDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopDetailVC animated:YES];
    shopDetailVC.hidesBottomBarWhenPushed = NO;
}

@end
