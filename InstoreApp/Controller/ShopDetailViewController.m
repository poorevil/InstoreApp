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

    [self initToolBar];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:YES];
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

-(void)initToolBar
{
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil action:nil];
    //添加评论
    UIButton *addCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCommentBtn sizeToFit];
    [addCommentBtn setImage:[UIImage imageNamed:@"store-icon-feed-black"] forState:UIControlStateNormal];
    [addCommentBtn addTarget:self action:@selector(addCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addCommentItem = [[UIBarButtonItem alloc] initWithCustomView:addCommentBtn];

    //喜欢
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeBtn sizeToFit];
    [likeBtn setImage:[UIImage imageNamed:@"store-icon-like-black"] forState:UIControlStateNormal];
    [likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *likeItem = [[UIBarButtonItem alloc] initWithCustomView:likeBtn];

    //收藏
    UIButton *favorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [favorBtn sizeToFit];
    [favorBtn setImage:[UIImage imageNamed:@"store-icon-fav-black"] forState:UIControlStateNormal];
    [favorBtn addTarget:self action:@selector(favorAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *favorItem = [[UIBarButtonItem alloc] initWithCustomView:favorBtn];

    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn sizeToFit];
    [shareBtn setImage:[UIImage imageNamed:@"store-icon-share-black"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(favorAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    self.toolbarItems = @[addCommentItem,flexibleSpace,likeItem,flexibleSpace,favorItem,flexibleSpace,shareItem];
}

//添加评论
-(void)addCommentAction:(id)sender
{
    
}

//添加喜欢
-(void)likeAction:(id)sender
{
    
}

//收藏
-(void)favorAction:(id)sender
{
    
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
    return 5;
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
        case 3:
            cellIdentifier = @"ShopDetailDescriptionCell";
            break;
        case 4:
            cellIdentifier = @"ShopDetailCommentsCell";
            break;
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
        case 3:
        case 4:
            return 95;
//        case 4:
//            cell.textLabel.text = @"品论列表";
//            break;
        default:
            return 44;
    }
}
@end
