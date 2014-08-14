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
#import "ShopDetailTypeCell.h"
#import "ShopDetailDescriptionCell.h"
#import "ShopDetailCommentsCell.h"

#import "StoreDetailInterface.h"
#import "StoreModel.h"

#import "StoreFocusInterface.h"

#import "SVProgressHUD.h"

@interface ShopDetailViewController () <StoreDetailInterfaceDelegate,StoreFocusInterfaceDelegate,ShopDetailDescriptionCellDelegate>

@property (nonatomic,strong) ShopDetailHeaderView *headerView;

@property (nonatomic,strong) StoreDetailInterface *storeDetailInterface;
@property (nonatomic,strong) StoreModel *storeModel;

@property (nonatomic,strong) StoreFocusInterface *storeFocusInterface;

@property (nonatomic,assign) BOOL isShowWholeDetailMsg;//是否显示全部描述

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
    
    self.storeDetailInterface = [[[StoreDetailInterface alloc] init] autorelease];
    self.storeDetailInterface.delegate = self;
//    [self.storeDetailInterface getStoreDetailByShopId:self.shopId commentSize:10 couponSize:10];
    [self.storeDetailInterface getStoreDetailByShopId:self.shopId];
    
    self.hidesBottomBarWhenPushed = YES;
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
    if (!self.headerView) {
        self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"ShopDetailHeaderView" owner:self options:nil] objectAtIndex:0];
        self.headerView.storeModel = self.storeModel;
        self.mtableView.tableHeaderView = self.headerView;
    }
    self.headerView.storeModel = self.storeModel;
}

-(void)initToolBar
{
    UIBarButtonItem *flexibleSpace = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil action:nil] autorelease];
    //添加评论
    UIButton *addCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCommentBtn sizeToFit];
    [addCommentBtn setImage:[UIImage imageNamed:@"store-icon-feed-black"] forState:UIControlStateNormal];
    [addCommentBtn addTarget:self action:@selector(addCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *addCommentItem = [[[UIBarButtonItem alloc] initWithCustomView:addCommentBtn] autorelease];

    //收藏
    UIButton *favorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [favorBtn sizeToFit];
    [favorBtn setImage:[UIImage imageNamed:@"store-icon-fav-black"] forState:UIControlStateNormal];
    [favorBtn addTarget:self action:@selector(favorAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *favorItem = [[[UIBarButtonItem alloc] initWithCustomView:favorBtn] autorelease];

    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn sizeToFit];
    [shareBtn setImage:[UIImage imageNamed:@"store-icon-share-black"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(favorAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[[UIBarButtonItem alloc] initWithCustomView:shareBtn] autorelease];
    
    self.toolbarItems = @[addCommentItem,flexibleSpace,favorItem,flexibleSpace,shareItem];
}

//添加评论
-(void)addCommentAction:(id)sender
{
    
}

//收藏
-(void)favorAction:(id)sender
{
    [SVProgressHUD showInView:self.view status:@"添加关注中，请稍后..."];
    self.storeFocusInterface = [[[StoreFocusInterface alloc] init] autorelease];
    self.storeFocusInterface.delegate = self;
    [self.storeFocusInterface setStoreFocusByShopIds:@[[NSString stringWithFormat:@"%d",self.storeModel.sid]] isUp:YES];
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.storeModel.coupons.count > 0 ? 5 : 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    
    if (self.storeModel.coupons.count > 0) {
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
    }else{
        switch (indexPath.section) {
            case 0:
                cellIdentifier = @"ShopDetailTypeCell";
                break;
            case 1:
                cellIdentifier = @"ShopDetailLocationCell";
                break;
            case 2:
                cellIdentifier = @"ShopDetailDescriptionCell";
                break;
            case 3:
                cellIdentifier = @"ShopDetailCommentsCell";
                break;
            default:
                break;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier
                                             owner:self
                                           options:nil] objectAtIndex:0];
    }
    
    if (self.storeModel.coupons.count > 0) {
        switch (indexPath.section) {
            case 0:{
                ShopDetailTypeCell *sdtc = (ShopDetailTypeCell *)cell;
                sdtc.storeModel = self.storeModel;
                break;
            }
            case 1:{
                ShopDetailLocationCell *sdtlc = (ShopDetailLocationCell *)cell;
                sdtlc.storeModel = self.storeModel;
                break;
            }
            case 2:{
                ShopDetailItemListCell *sditc = (ShopDetailItemListCell *)cell;
                sditc.storeModel = self.storeModel;
                break;
            }
            case 3:{
                ShopDetailDescriptionCell *sddtc = (ShopDetailDescriptionCell *)cell;
                sddtc.descLabel.text = self.storeModel.descStr;
                sddtc.delegate = self;
                
                CGRect frame = sddtc.frame;
                if (self.isShowWholeDetailMsg){
                    //计算内容的size
                    CGSize labelFontSize = [self.storeModel.descStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                               constrainedToSize:CGSizeMake(280, 999)
                                                                   lineBreakMode:NSLineBreakByWordWrapping];
                    frame.size.height = labelFontSize.height + 95 - 54;
                    sddtc.frame = frame;
                }else{
                    frame.size.height = 95;
                    sddtc.frame = frame;
                }
                
                break;
            }
            case 4:{
                ShopDetailCommentsCell *sdctc = (ShopDetailCommentsCell *)cell;
                sdctc.storeModel = self.storeModel;
                break;
            }
            default:
                break;
        }
    }else{
        switch (indexPath.section) {
            case 0:{
                ShopDetailTypeCell *sdtc = (ShopDetailTypeCell *)cell;
                sdtc.storeModel = self.storeModel;
                break;
            }
            case 1:{
                ShopDetailLocationCell *sdtlc = (ShopDetailLocationCell *)cell;
                sdtlc.storeModel = self.storeModel;
                break;
            }
            case 2:{
                ShopDetailDescriptionCell *sddtc = (ShopDetailDescriptionCell *)cell;
                sddtc.descLabel.text = self.storeModel.descStr;
                sddtc.delegate = self;
                
                CGRect frame = sddtc.frame;
                if (self.isShowWholeDetailMsg){
                    //计算内容的size
                    CGSize labelFontSize = [self.storeModel.descStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                               constrainedToSize:CGSizeMake(280, 999)
                                                                   lineBreakMode:NSLineBreakByWordWrapping];
                    frame.size.height = labelFontSize.height + 95 - 54;
                    sddtc.frame = frame;
                }else{
                    frame.size.height = 95;
                    sddtc.frame = frame;
                }
                
                break;
            }
            case 3:{
                ShopDetailCommentsCell *sdctc = (ShopDetailCommentsCell *)cell;
                sdctc.storeModel = self.storeModel;
                break;
            }
            default:
                break;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.storeModel.coupons.count > 0) {
        switch (indexPath.section) {
            case 0:
            case 1:
                return 44;
            case 2:
                return 95;
            case 3:{
                if (self.isShowWholeDetailMsg) {
                    //计算内容的size
                    CGSize labelFontSize = [self.storeModel.descStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                                       constrainedToSize:CGSizeMake(280, 999)
                                                                           lineBreakMode:NSLineBreakByWordWrapping];
                    
                    return labelFontSize.height + 95 - 54;
                }else
                    return 95;
            }
            case 4:
                return 95;
            default:
                return 44;
        }
    }else{
        switch (indexPath.section) {
            case 0:
            case 1:
                return 44;
            case 2:{
                if (self.isShowWholeDetailMsg) {
                    //计算内容的size
                    CGSize labelFontSize = [self.storeModel.descStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                               constrainedToSize:CGSizeMake(280, 999)
                                                                   lineBreakMode:NSLineBreakByWordWrapping];
                    
                    return labelFontSize.height + 95 - 54;
                }else
                    return 95;
            }
            case 3:
                return 95;
            default:
                return 44;
        }
    }
}

#pragma mark - StoreDetailInterfaceDelegate <NSObject>
-(void)getStoreDetailDidFinished:(StoreModel*)storeModel
{
    self.storeModel = storeModel;
    [self initHeaderView];
    [self.mtableView reloadData];
}

-(void)getStoreDetailDidFailed:(NSString *)errorMessage
{
    DebugLog(@"%@",errorMessage);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
}

#pragma mark - StoreFocusInterfaceDelegate <NSObject>
-(void)setStoreFocusDidFinished
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注成功" message:nil delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)setStoreFocusDidFailed:(NSString *)errorMessage
{
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关注失败" message:nil delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - ShopDetailDescriptionCellDelegate <NSObject>
-(void)isShowDetailMessage:(BOOL)show
{
    self.isShowWholeDetailMsg = show;
    [self.mtableView reloadData];
}

-(void)dealloc
{
    self.mtableView = nil;
    self.headerView = nil;
    self.storeDetailInterface.delegate = nil;
    self.storeDetailInterface = nil;
    self.storeModel = nil;
    self.storeFocusInterface.delegate = nil;
    self.storeFocusInterface = nil;
    
    [super dealloc];
}

@end
