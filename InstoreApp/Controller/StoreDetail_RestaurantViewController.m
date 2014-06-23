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

@interface StoreDetail_RestaurantViewController () <StoreDetailInterfaceDelegate>

@property (nonatomic, retain) StoreModel *storeModel;
@property (nonatomic, retain) StoreDetail_headerView *headerView;

@property (nonatomic, retain) StoreDetailInterface *storeDetailInterface;
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
    
    self.storeDetailInterface = [[StoreDetailInterface alloc] init];
    self.storeDetailInterface.delegate = self;
    [self.storeDetailInterface getStoreDetailByShopId:self.shopId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mtableView = nil;
    
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
    }
    
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.storeModel.comments.count) {
        return 4;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    if (self.storeModel.comments.count) {
        switch (indexPath.section) {
            case 0:
                cellIdentifier = @"StoreDetail_cardCell";
                break;
            case 1:
                cellIdentifier = @"StoreDetail_detailCell";
                break;
            case 2:
                cellIdentifier = @"CommentListCell";
                break;
            case 3:
                cellIdentifier = @"StoreDetail_otherCouponCell";
                break;
                
            default:
                break;
        }
    }else{
        {
            switch (indexPath.section) {
                case 0:
                    cellIdentifier = @"StoreDetail_cardCell";
                    break;
                case 1:
                    cellIdentifier = @"StoreDetail_detailCell";
                    break;
                case 2:
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
    
    if ([cell isMemberOfClass:[StoreDetail_cardCell class]]) {
        StoreDetail_cardCell *cardCell = (StoreDetail_cardCell *)cell;
        cardCell.cardLabel.text = @"blablabla";
    }else if ([cell isMemberOfClass:[StoreDetail_detailCell class]]) {
        StoreDetail_detailCell *detailCell = (StoreDetail_detailCell *)cell;
        detailCell.detailLabel.text = self.storeModel.descStr;
        CGSize labelFontSize = [self.storeModel.descStr sizeWithFont:detailCell.detailLabel.font
                                                   constrainedToSize:CGSizeMake(300, 999)
                                                       lineBreakMode:detailCell.detailLabel.lineBreakMode];
        detailCell.detailLabel.frame = CGRectMake(10, 10, labelFontSize.width, labelFontSize.height);
        detailCell.frame = CGRectMake(0, 0, 320, labelFontSize.height+20);
        
        
    }else if ([cell isMemberOfClass:[CommentListCell class]]) {
        CommentListCell *commentCell = (CommentListCell *)cell;
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
            case 0:
                return 40;
            case 1:{
                CGSize labelFontSize = [self.storeModel.descStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 999) lineBreakMode:NSLineBreakByWordWrapping];
                return labelFontSize.height+20;
            }case 2:
                return 126;
            case 3:
                return 80*self.storeModel.coupons.count+41;
            default:
                return 44;
        }
    }else{
        switch (indexPath.section) {
            case 0:
                return 40;
            case 1:{
                CGSize labelFontSize = [self.storeModel.descStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 999) lineBreakMode:NSLineBreakByWordWrapping];
                return labelFontSize.height+20;
            }case 2:
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
