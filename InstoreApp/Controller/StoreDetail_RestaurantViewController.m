//
//  StoreDetail_RestaurantViewController.m
//  InstoreApp
//
//  Created by evil on 14-6-20.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreDetail_RestaurantViewController.h"
#import "StoreModel.h"
#import "StoreDetailInterface.h"

#import "StoreDetail_cardCell.h"
#import "StoreDetail_headerView.h"
#import "StoreDetail_cardCell.h"
#import "StoreDetail_detailCell.h"
#import "StoreDetail_otherCouponCell.h"
#import "CommentListCell.h"

#import "EGOImageView.h"

#import "FocusStoreInterface.h"

#import "UIViewController+ShareToWeChat.h"

@interface StoreDetail_RestaurantViewController () <StoreDetailInterfaceDelegate>

@property (nonatomic, retain) StoreModel *storeModel;
@property (nonatomic, retain) StoreDetail_headerView *headerView;

@property (nonatomic, retain) StoreDetailInterface *storeDetailInterface;

@property (nonatomic, retain) UIButton *focuseBtn;

@property (nonatomic, retain) FocusStoreInterface *focusStoreInterface;
@end

@implementation StoreDetail_RestaurantViewController

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
    
    self.detailCellHeight = 102;
    
    //init navigater
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f
                                                                             green:40.0f/255.0f
                                                                              blue:53.0f/255.0f
                                                                             alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.focuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *imageName = @"nav_focuse_btn";
    if (self.storeModel.isFocus) {
        imageName = @"nav_focuse_pressed_btn";
    }
    [self.focuseBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.focuseBtn addTarget:self action:@selector(focuseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.focuseBtn sizeToFit];
    UIBarButtonItem *focuseBarBtn = [[[UIBarButtonItem alloc] initWithCustomView:self.focuseBtn] autorelease];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"share_white"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnAction)
       forControlEvents:UIControlEventTouchUpInside];
    [shareBtn sizeToFit];
    UIBarButtonItem *shareBarBtn = [[[UIBarButtonItem alloc] initWithCustomView:shareBtn] autorelease];
    
    self.navigationItem.rightBarButtonItems =@[shareBarBtn, focuseBarBtn];
    
    self.storeDetailInterface = [[[StoreDetailInterface alloc] init]autorelease];
    self.storeDetailInterface.delegate = self;
    [self.storeDetailInterface getStoreDetailByShopId:self.shopId];
    
    self.hidesBottomBarWhenPushed = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mtableView = nil;
    self.storeModel = nil;
    self.storeDetailInterface = nil;
    self.headerView = nil;
    
    self.focuseBtn = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)initHeaderView
{
    if (!self.headerView) {
        self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetail_headerView"
                                                        owner:self
                                                      options:nil] objectAtIndex:0];
        self.mtableView.tableHeaderView = self.headerView;
    }
    
    if (self.storeModel) {
        self.headerView.storeModel = self.storeModel;
        
        NSString *imageName = @"nav_focuse_btn";
        if (self.storeModel.isFocus) {
            imageName = @"nav_focuse_pressed_btn";
        }
        [self.focuseBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}

-(void)focuseBtnAction
{
    self.focusStoreInterface = [[[FocusStoreInterface alloc] init] autorelease];
    NSString *msg = @"";
    if (self.storeModel.isFocus) {
        [self.focusStoreInterface focusStoreWithID:self.storeModel.sid WithMethod:@"DELETE"];
        [self.focuseBtn setImage:[UIImage imageNamed:@"nav_focuse_btn"]
                        forState:UIControlStateNormal];
        msg = @"取消关注成功";
        self.storeModel.isFocus = NO;
    }else{
        [self.focusStoreInterface focusStoreWithID:self.storeModel.sid WithMethod:@"PUT"];
        [self.focuseBtn setImage:[UIImage imageNamed:@"nav_focuse_pressed_btn"]
                        forState:UIControlStateNormal];
        msg = @"关注成功";
        self.storeModel.isFocus = YES;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
}

-(void)shareBtnAction
{
    [self shareToWeChatWithTitle:self.storeModel.title Description:nil LinkURL:[NSString stringWithFormat:@"%@/m/%@/store/detail/%d",BASE_INTERFACE_DOMAIN,MALL_CODE,self.storeModel.sid]];
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.storeModel.comments.count) {
        return 3;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    if (self.storeModel.comments.count) {
        switch (indexPath.section) {
            case 0:
                cellIdentifier = @"StoreDetail_detailCell";
                break;
            case 1:
                cellIdentifier = @"CommentListCell";
                break;
            case 2:
                cellIdentifier = @"StoreDetail_otherCouponCell";
                break;
                
            default:
                break;
        }
    }else{
        {
            switch (indexPath.section) {
                case 0:
                    cellIdentifier = @"StoreDetail_detailCell";
                    break;
                case 1:
                    cellIdentifier = @"StoreDetail_otherCouponCell";
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier
                                             owner:self
                                            options:nil] objectAtIndex:0];
    }
    
    if ([cell isMemberOfClass:[StoreDetail_detailCell class]]) {
        StoreDetail_detailCell *detailCell = (StoreDetail_detailCell *)cell;
        detailCell.detailLabel.text = self.storeModel.descStr;
        detailCell.delegate = self;
        
    }else if ([cell isMemberOfClass:[CommentListCell class]]) {
//        CommentListCell *commentCell = (CommentListCell *)cell;
        //TODO:commentCell.commentList = self.storeModel.comments;
    }else if ([cell isMemberOfClass:[StoreDetail_otherCouponCell class]]) {
        StoreDetail_otherCouponCell *couponCell = (StoreDetail_otherCouponCell *)cell;
        couponCell.coupons  = self.storeModel.coupons;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.storeModel.comments.count) {
        switch (indexPath.section) {
            case 0:{
                return self.detailCellHeight;
            }case 1:
                return 126;
            case 2:
                return 80*self.storeModel.coupons.count+41;
            default:
                return 44;
        }
    }else{
        switch (indexPath.section) {
            case 0:{
                return self.detailCellHeight;
            }case 1:
                return 80*self.storeModel.coupons.count+41;
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
    NSLog(@"%@",errorMessage);
}

@end
