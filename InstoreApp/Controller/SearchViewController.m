//
//  SearchViewController.m
//  InstoreApp
//
//  Created by han chao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@end

@implementation SearchViewController

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
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f
                                                                             green:40.0f/255.0f
                                                                              blue:53.0f/255.0f
                                                                             alpha:1]];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    cancelBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelBtn;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"请输入关键词";
    self.searchBar.showsCancelButton = YES;

//    [self.searchBar setTintColor:[UIColor blackColor]];
//    [self.searchBar setSearchTextPositionAdjustment:UIOffsetMake(30, 0)];// 设置搜索框中文本框的文本偏移量
    [self.searchBar sizeToFit];

    self.navigationItem.titleView = self.searchBar;
    [self.searchBar becomeFirstResponder];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    double delayInSeconds = 0.05;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^{
//            [self.searchBar becomeFirstResponder];
//    });

//    [self.searchBar performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.05];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(void)cancelAction
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.textColor = [UIColor colorWithRed:106/255.0f
                                                   green:106/255.0f
                                                    blue:106/255.0f
                                                   alpha:1];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"电影院";
            break;
        case 1:
            cell.textLabel.text = @"牛仔裤 三折";
            break;
        case 2:
            cell.textLabel.text = @"披萨";
            break;
        case 3:
            cell.textLabel.text = @"阿迪达斯";
            break;
        default:
            break;
    }
    return cell;
}



@end
