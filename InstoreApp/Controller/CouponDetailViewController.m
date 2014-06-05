//
//  CouponDetailViewController.m
//  InstoreApp
//
//  Created by hanchao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponDetailViewController.h"
#import "CouponDetailWithTitleCell.h"
#import "CouponDetailInterface.h"
#import "EGOImageView.h"
#import "CouponModel.h"
#import "StoreModel.h"
#import "FloorModel.h"
#import "PositionModel.h"
#import "CouponDownloadInterface.h"
#import "CouponDetailDownloadCell.h"
#import "NSDate+DynamicDateString.h"
#import "CouponDownloadModel.h"
#import "SVProgressHUD.h"

#import "PhotoViewController.h"

@interface CouponDetailViewController () <CouponDetailInterfaceDelegate,CouponDownloadInterfaceDelegate>
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,strong) CouponDetailInterface *couponDetailInterface;

@property (nonatomic,strong) EGOImageView *headerImageView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) CouponDownloadInterface *couponDownloadInterface;

@property (nonatomic,strong) UIButton *downloadBtn;
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
    
    self.couponDetailInterface = [[[CouponDetailInterface alloc] init] autorelease];
    self.couponDetailInterface.delegate = self;
    [self.couponDetailInterface getCouponDetailByCouponId:self.couponModel.cid];
    
    [self initHeaderView];
    [self initFooterView];
    
    self.title = @"优惠劵详情";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(void)refreshUI
{
//    [self initHeaderView];
    [self initFooterView];
    [self.mtableView reloadData];
}

//初始化头部view
-(void)initHeaderView
{
    if (!self.headerView) {
        self.headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)] autorelease];
        self.headerImageView = [[[EGOImageView alloc] init] autorelease];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.frame = CGRectMake(10, 10, 300, 300);
        [self.headerView addSubview:self.headerImageView];
        
        self.headerImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagesTapAction:)];
        [self.headerImageView addGestureRecognizer:tap];
        [tap release];
        
        UIView *titleGroupView = [[[UIView alloc] initWithFrame:CGRectMake(10, 320-34, 300, 34)] autorelease];
        titleGroupView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 28)] autorelease];
        self.titleLabel.textColor = [UIColor whiteColor];
        [titleGroupView addSubview:self.titleLabel];
        
        [self.headerView addSubview:titleGroupView];
        self.mtableView.tableHeaderView = self.headerView;
    }
    
    self.headerImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/640*640.png",self.couponModel.imageUrl]];
    self.titleLabel.text = self.couponModel.title;
    
}

-(void)imagesTapAction:(UIGestureRecognizer *)sender
{
    PhotoViewController *photoViewController = [[[PhotoViewController alloc] init] autorelease];
    photoViewController.currentImageUrl = [self.couponModel.images objectAtIndex:0];
    photoViewController.imageListUrl = self.couponModel.images;
    
    [self.navigationController pushViewController:photoViewController animated:NO];
}

-(void)initFooterView
{
    if (self.couponModel.type==2) {//1: 优惠活动; 2: 优惠券; 3: 团购;
        self.footerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
        self.downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *originalImage = [UIImage imageNamed:@"store-btn-sb-red"];
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 6, 300);
        UIImage *normalBg = [originalImage resizableImageWithCapInsets:insets];
        
        originalImage = [UIImage imageNamed:@"store-btn-sb-red-pressed"];
        UIImage *pressedBg = [originalImage resizableImageWithCapInsets:insets];
        
        [self.downloadBtn setBackgroundImage:normalBg forState:UIControlStateNormal];
        [self.downloadBtn setBackgroundImage:pressedBg forState:UIControlStateSelected];
        [self.downloadBtn setBackgroundImage:pressedBg forState:UIControlStateHighlighted];
        [self.downloadBtn setBackgroundImage:pressedBg forState:UIControlStateDisabled];
        [self.downloadBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        
        [self.downloadBtn setTitle:@"立即下载" forState:UIControlStateNormal];
        self.downloadBtn.frame = CGRectMake((320-280)/2,
                                       2,
                                       280,
                                       40);
        [self.downloadBtn addTarget:self action:@selector(downloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:self.downloadBtn];
        self.mtableView.tableFooterView = self.footerView;
        
        if (self.couponModel.userCollectCount > 0) {
            self.downloadBtn.enabled = NO;
        }
    }
}

-(void)downloadBtnAction:(id)sender
{
    [SVProgressHUD showInView:self.view status:@"下载中，请稍后..."];
    self.downloadBtn.enabled = NO;
    self.couponDownloadInterface = [[[CouponDownloadInterface alloc] init] autorelease];
    self.couponDownloadInterface.delegate = self;
    [self.couponDownloadInterface getCouponDownloadByCouponId:self.couponModel.cid];
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
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
    
    
    switch (indexPath.section) {
        case 0:
            cellIdentifier = @"CouponDetailDownloadCell";
            break;
        case 1:
            cellIdentifier = @"CouponDetailWithTitleCell";
            break;
        case 2:
            cellIdentifier = @"cell";
            break;
        case 3:
            cellIdentifier = @"CouponDetailWithTitleCell";
            break;
        default:
            cellIdentifier = @"cell";
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        if ([cellIdentifier isEqualToString:@"cell"]) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentifier] autorelease];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self
                                               options:nil] objectAtIndex:0];
        }
    }
    
    switch (indexPath.section) {
        case 0:{
            CouponDetailDownloadCell *cddc = (CouponDetailDownloadCell *)cell;
            cddc.downloadNumLabel.text = [NSString stringWithFormat:@"%d",self.couponModel.collectCount];
//            cddc.favNumLabel.text = [NSString stringWithFormat:@"%d",self.couponModel.collectCount];
            cddc.favNumLabel.hidden = YES;
            
            break;
        }
        case 1:
            if ([cell isMemberOfClass:[CouponDetailWithTitleCell class]]) {
                CouponDetailWithTitleCell *withTitleCell = (CouponDetailWithTitleCell *)cell;
                withTitleCell.titleLabel.text = @"有效期";
                withTitleCell.iconView.image = [UIImage imageNamed:@"store-icon-clock"];
                withTitleCell.detailLabel.text = [NSString stringWithFormat:@"%@ 至 %@",
                                                  [self.couponModel.startTime toDateString],
                                                  [self.couponModel.endTime toDateString]];
                withTitleCell.detailLabel.numberOfLines = 99;
                withTitleCell.detailLabel.frame = CGRectMake(withTitleCell.detailLabel.frame.origin.x,
                                                             withTitleCell.detailLabel.frame.origin.y,
                                                             withTitleCell.detailLabel.frame.size.width,
                                                             44);
                withTitleCell.frame = CGRectMake(0, 0, withTitleCell.frame.size.width, 44);
            }
            break;
        case 2:
            if (self.couponModel.store) {
                switch (indexPath.row) {
                    case 0:
                        cell.textLabel.text = [NSString stringWithFormat:@"商户：%@",self.couponModel.store.title];
                        break;
                    case 1:
                        cell.textLabel.text = [NSString stringWithFormat:@"地址：%@",self.couponModel.store.address];
                        break;
                    case 2:
                        cell.textLabel.text = [NSString stringWithFormat:@"电话：%@",self.couponModel.store.tel?self.couponModel.store.tel:@""];
                        break;
                    default:
                        break;
                }
            }
            break;
        case 3:
            if ([cell isMemberOfClass:[CouponDetailWithTitleCell class]]) {
                CouponDetailWithTitleCell *withTitleCell = (CouponDetailWithTitleCell *)cell;
                withTitleCell.titleLabel.text = @"优惠劵详情";
                withTitleCell.iconView.image = [UIImage imageNamed:@"store-icon-feed"];
                withTitleCell.detailLabel.text = self.couponModel.descriptionStr;
                withTitleCell.detailLabel.numberOfLines = 39;
                //计算内容的size
                CGSize labelFontSize = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                                   constrainedToSize:CGSizeMake(280, 999)
                                                                       lineBreakMode:NSLineBreakByWordWrapping];
                
                withTitleCell.detailLabel.frame = CGRectMake(withTitleCell.detailLabel.frame.origin.x,
                                                             withTitleCell.detailLabel.frame.origin.y,
                                                             withTitleCell.detailLabel.frame.size.width,
                                                             labelFontSize.height);
                withTitleCell.frame = CGRectMake(0, 0, withTitleCell.frame.size.width, 370);
            }

            
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        if (tableView == self.mtableView) {
            
            CGFloat cornerRadius = 5.f;
            
            cell.backgroundColor = UIColor.clearColor;
            
            CAShapeLayer *layer = [[[CAShapeLayer alloc] init] autorelease];
            
            CGMutablePathRef pathRef = CGPathCreateMutable();
            
            CGRect bounds = CGRectInset(cell.bounds, 10, 0);
            
            BOOL addLine = NO;
            
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                
                if (indexPath.section == 0 && tableView.tableHeaderView) {
                    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                    
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                    
                    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                    
                    CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
                }else{
                    CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
                }
                
            } else if (indexPath.row == 0) {
                
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                
                addLine = YES;
                
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
                
            } else {
                
                CGPathAddRect(pathRef, nil, bounds);
                
                addLine = YES;
                
            }
            
            layer.path = pathRef;
            
            CFRelease(pathRef);
            
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            layer.strokeColor = [UIColor lightGrayColor].CGColor;
            layer.lineWidth = 0.4f;
            
            
            if (addLine == YES) {
                CALayer *lineLayer = [[[CALayer alloc] init] autorelease];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
                
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                
                [layer addSublayer:lineLayer];
                
            }
            
            UIView *testView = [[[UIView alloc] initWithFrame:bounds] autorelease];
            
            [testView.layer insertSublayer:layer atIndex:0];
            
            testView.backgroundColor = UIColor.clearColor;
            
            cell.backgroundView = testView;
            
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 44;
        case 1:
            return 88;
        case 2:
            return 44;
        case 3:{
            //计算内容的size
            CGSize labelFontSize = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14]
                                          constrainedToSize:CGSizeMake(280, 999)
                                              lineBreakMode:NSLineBreakByWordWrapping];
            
            
            
            return labelFontSize.height+60;
        }
        default:
            return 44;
    }
    
}

#pragma mark - CouponDetailInterfaceDelegate <NSObject>

-(void)getCouponDetailDidFinished:(CouponModel *)couponModel
{
    self.couponModel = couponModel;
    [self refreshUI];
}

-(void)getCouponDetailDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

#pragma mark - CouponDownloadInterfaceDelegate <NSObject>
-(void)getCouponDownloadDidFinished:(CouponDownloadModel *)couponDownloadModel
{
    [SVProgressHUD dismiss];
    //status: '下载结果',            // 1: 成功; 2: X; 3: 失败-已下载过; 4: 失败-不符合参与条件
    NSString *title = nil;
    switch (couponDownloadModel.status) {
        case 1:
            title = @"成功";
            break;
        case 2:
            title = @"X";//??
            break;
        case 3:
            title = @"失败-已下载过";
            break;
        case 4:
            title = @"失败-不符合参与条件";
            break;
        default:
            break;
    }
    
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:title
                                                    message:couponDownloadModel.status==1?
                                                              [NSString stringWithFormat:@"优惠代码:%d",couponDownloadModel.couponCode]:
                                                              couponDownloadModel.msg
                                                   delegate:nil
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles: nil] autorelease];
    [alert show];
}

-(void)getCouponDownloadDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
    [SVProgressHUD dismiss];
    
    self.downloadBtn.enabled = YES;
}

-(void)dealloc
{
    self.couponModel = nil;
    self.mtableView = nil;

    self.headerView = nil;
    self.footerView = nil;
    self.couponDetailInterface.delegate = nil;
    self.couponDetailInterface = nil;
    self.couponDownloadInterface.delegate = nil;
    self.couponDownloadInterface = nil;
    self.headerImageView = nil;
    self.titleLabel = nil;
    self.downloadBtn = nil;
    
    [super dealloc];
}

@end
