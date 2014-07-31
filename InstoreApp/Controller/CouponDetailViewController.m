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

#import "CouponDetailStoreCell.h"

#import "PhotoViewController.h"

#import "FocusInterface.h"
#import "WebViewController.h"
#import "DownloadCouponDetailViewController.h"
#import "DownloadCouponSuccessViewController.h"
#import "MallNewsDetail_threeCell.h"
#import "StoreDetail_RestaurantViewController.h"
//#import "UIViewController+ShareToWeChat.h"
#import "ShareToWeChatViewController.h"
#import "GroupBuyDetailCardCell.h"
#import "BankCardModel.h"


@interface CouponDetailViewController () <CouponDetailInterfaceDelegate,CouponDownloadInterfaceDelegate,ShareToWeChatDeleate>{
    ShareToWeChatViewController *shareVC;
}
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,strong) CouponDetailInterface *couponDetailInterface;

@property (nonatomic,strong) EGOImageView *headerImageView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) CouponDownloadInterface *couponDownloadInterface;

@property (nonatomic,strong) UIButton *downloadBtn;

@property (retain, nonatomic) FocusInterface *focusInterface;

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
    
    self.title = @"优惠劵详情";
    
    self.focusInterface = [[[FocusInterface alloc]init]autorelease];
    
    self.hidesBottomBarWhenPushed = YES;
    
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShare.frame = CGRectMake(0, 0, 28, 44);
    [btnShare setImage:[UIImage imageNamed:@"share_white.png"] forState:UIControlStateNormal];
    [btnShare setImageEdgeInsets:UIEdgeInsetsMake(13, 5, 13, 5)];
    [btnShare addTarget:self action:@selector(btnShareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:btnShare];
    self.navigationItem.rightBarButtonItems = @[barItem];
    [barItem release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(void)refreshUI
{
    [self.mtableView reloadData];
}

//初始化头部view
-(void)initHeaderView
{
    if (!self.headerView) {
        self.headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)] autorelease];
        self.headerImageView = [[[EGOImageView alloc] init] autorelease];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.clipsToBounds = YES;
        self.headerImageView.frame = self.headerView.bounds;
        [self.headerView addSubview:self.headerImageView];
        
        self.headerImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagesTapAction:)];
        [self.headerImageView addGestureRecognizer:tap];
        [tap release];
        
        UIView *titleGroupView = [[[UIView alloc] initWithFrame:CGRectMake(0,
                                                                           self.headerView.frame.size.height-16,
                                                                           self.headerView.frame.size.width, 16)] autorelease];
        titleGroupView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
//        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 28)] autorelease];
//        self.titleLabel.textColor = [UIColor whiteColor];
        //TODO:pageControl
        
        [titleGroupView addSubview:self.titleLabel];
        
        [self.headerView addSubview:titleGroupView];
        self.mtableView.tableHeaderView = self.headerView;
    }
    
    self.headerImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/640*640.png",self.couponModel.imageUrl]];
//    self.titleLabel.text = self.couponModel.title;
    
}

-(void)imagesTapAction:(UIGestureRecognizer *)sender
{
    if (self.couponModel.images.count > 0) {
        PhotoViewController *photoViewController = [[[PhotoViewController alloc] init] autorelease];
        photoViewController.hidesBottomBarWhenPushed = YES;
        self.hidesBottomBarWhenPushed = YES;
        photoViewController.currentImageUrl = [self.couponModel.images objectAtIndex:0];
        photoViewController.imageListUrl = self.couponModel.images;
        
        [self.navigationController pushViewController:photoViewController animated:NO];
    }
}


-(void)downloadBtnAction:(id)sender
{
//    [SVProgressHUD showInView:self.view status:@"下载中，请稍后..."];
//    self.downloadBtn.enabled = NO;
//    self.couponDownloadInterface = [[[CouponDownloadInterface alloc] init] autorelease];
//    self.couponDownloadInterface.delegate = self;
//    [self.couponDownloadInterface getCouponDownloadByCouponId:self.couponModel.cid];
}

#pragma mark - UITableViewDataSource<NSObject>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;//title
        case 1:
            return 1;
        case 2:
            return 1;//有效期
        case 3:
            return 3;//商户。。。
        case 4:
            return 1;//优惠劵详情
            
        default:
            return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 36;
        case 1:
            return 40;
        case 2:
            return 72;
        case 3:
            return 50;
        case 4:{
            //计算内容的size
            CGSize labelFontSize = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                               constrainedToSize:CGSizeMake(300, 999)
                                                                   lineBreakMode:NSLineBreakByWordWrapping];
            return labelFontSize.height+60;
        }
        default:
            return 44;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    switch (indexPath.section) {
        case 0:
            cellIdentifier = @"CouponDetailDownloadCell";
            break;
        case 1:
            cellIdentifier = @"GroupBuyDetailCardCell";
            break;
        case 2:
            cellIdentifier = @"CouponDetailWithTitleCell";
            break;
        case 3:
            cellIdentifier = @"MallNewsDetail_threeCell";
            break;
        case 4:
            cellIdentifier = @"CouponDetailWithTitleCell";
            break;
        default:
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
            cddc.titleLabel.text = self.couponModel.title;
            cddc.favNumLabel.text = [NSString stringWithFormat:@"%d",self.couponModel.collectCount];
//            cddc.favNumLabel.hidden = YES;
            
            break;
        }
        case 1:{
            GroupBuyDetailCardCell *cellBank = (GroupBuyDetailCardCell *)cell;
            if (self.couponModel.banklist.count > 0) {
                NSString *str = @"银行卡专属：";
                for (BankCardModel *model in self.couponModel.banklist) {
                    str = [NSString stringWithFormat:@"%@%@ ",str,model.name];
                }
                cellBank.cardsLabel.text = str;
            }else{
                cellBank.cardsLabel.text = @"银行卡专属：无";
            }
        }
            break;
        case 2:
            if ([cell isMemberOfClass:[CouponDetailWithTitleCell class]]) {
                CouponDetailWithTitleCell *withTitleCell = (CouponDetailWithTitleCell *)cell;
                withTitleCell.titleLabel.text = @"有效期";
                withTitleCell.iconView.image = [UIImage imageNamed:@"store-icon-clock"];
                withTitleCell.detailLabel.text = [NSString stringWithFormat:@"%@ 至 %@",
                                                  [self.couponModel.startTime toDateString],
                                                  [self.couponModel.endTime toDateString]];
            }
            break;
        case 3:{
            MallNewsDetail_threeCell *threeCell = (MallNewsDetail_threeCell *)cell;
            threeCell.selectionStyle = UITableViewCellSelectionStyleGray;
            switch (indexPath.row) {
                case 0:
                {
                    threeCell.iconImage.image = [UIImage imageNamed:@"Icon_store.png"];
                    threeCell.labClass.text = @"商户";
                    threeCell.labName.text = self.couponModel.store.title;
                }
                    break;
                case 1:
                {
                    threeCell.iconImage.image = [UIImage imageNamed:@"Icon_address.png"];
                    threeCell.labClass.text = @"地址";
                    threeCell.labName.text = [NSString stringWithFormat:@"%@ %@",self.couponModel.store.position.floor.fName,self.couponModel.store.position.roomNum];
                }
                    break;
                case 2:
                {
                    threeCell.iconImage.image = [UIImage imageNamed:@"Icon_phone.png"];
                    threeCell.labClass.text = @"电话";
                    threeCell.labName.textColor = [UIColor colorWithRed:60/255.0 green:179/255.0 blue:235/255.0 alpha:1];
                    threeCell.labName.text = self.couponModel.store.tel;
                    threeCell.separatorView.hidden = YES;
                    break;
                }
            }
        }
            break;
        case 4:
            if ([cell isMemberOfClass:[CouponDetailWithTitleCell class]]) {
                CouponDetailWithTitleCell *withTitleCell = (CouponDetailWithTitleCell *)cell;
                withTitleCell.titleLabel.text = @"优惠劵详情";
                withTitleCell.iconView.image = [UIImage imageNamed:@"store-icon-feed"];
                withTitleCell.detailLabel.text = self.couponModel.descriptionStr;
                withTitleCell.detailLabel.numberOfLines = 39;
                //计算内容的size
                CGSize labelFontSize = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                                   constrainedToSize:CGSizeMake(300, 999)
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
            {
                //商户
                StoreDetail_RestaurantViewController *vc = [[StoreDetail_RestaurantViewController alloc]initWithNibName:@"StoreDetail_RestaurantViewController" bundle:nil];
                vc.shopId = self.couponModel.store.sid;
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
            }
                break;
            case 1:{
                //地址
                
            }
                break;
            case 2:{
                //电话
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.couponModel.store.tel]]];
            }
                break;
            default:
                break;
        }
    }
}


#pragma mark - CouponDetailInterfaceDelegate <NSObject>

-(void)getCouponDetailDidFinished:(CouponModel *)couponModel
{
    self.couponModel = couponModel;
    [self refreshUI];
    if (couponModel.isFocus) {
        [self.btnFocus setTitle:@"已收藏" forState:UIControlStateNormal];
    }
    if (couponModel.userCollectCount) {
        [self.btnGoNext setTitle:@"已下载" forState:UIControlStateNormal];
    }
//    if (couponModel.link) {
//        self.btnGoNext.enabled = YES;
//    }
}

-(void)getCouponDetailDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

#pragma mark - CouponDownloadInterfaceDelegate <NSObject>
-(void)getCouponDownloadDidFinished:(CouponDownloadModel *)couponDownloadModel
{
    [SVProgressHUD dismiss];

    
    //status: '下载结果',  1: 成功; 2: 成功-已下载; 3: 失败-已下载过; 4: 失败-不符合参与条件;5: 失败-已抢完
    if (couponDownloadModel.status == 1 || couponDownloadModel.status == 2) {
        [self.btnGoNext setTitle:@"已下载" forState:UIControlStateNormal];
        self.couponModel.userCollectCount = 1;
        
        DownloadCouponSuccessViewController *vc = [[DownloadCouponSuccessViewController alloc]initWithNibName:@"DownloadCouponSuccessViewController" bundle:nil];
        vc.titleStr = self.couponModel.title;
        vc.imageURL = [self.couponModel.images objectAtIndex:0];
        vc.couponDownloadModel = couponDownloadModel;
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载失败" message:couponDownloadModel.msg delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil,nil];
        [alert show];
        [alert release];
    }
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
    
    self.focusInterface = nil;
    
    [_btnFocus release];
    [_btnGoNext release];
    [super dealloc];
}

- (IBAction)btnFocusAction:(UIButton *)sender {
    if (self.couponModel.isFocus == YES) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您已经收藏过了！" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }else{
        [self.focusInterface sendFocusCouponID:self.couponModel.cid];
        self.couponModel.isFocus = YES;
        [sender setTitle:@"已收藏" forState:UIControlStateNormal];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"收藏成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}
- (IBAction)btnGoNextAction:(UIButton *)sender {
    if (self.couponModel.userCollectCount == 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该优惠券已下载" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    
    [SVProgressHUD showInView:self.view status:@"下载中，请稍后..."];
    if (!self.couponDownloadInterface) {
        self.couponDownloadInterface = [[[CouponDownloadInterface alloc] init] autorelease];
        self.couponDownloadInterface.delegate = self;
    }
    [self.couponDownloadInterface getCouponDownloadByCouponId:self.couponModel.cid];
}

-(void)btnShareAction:(UIButton *)sender{
    //    [self shareToWeChatWithTitle:self.couponModel.title Description:nil LinkURL:[NSString stringWithFormat:@"%@/m/%@/coupon/detail/%d",BASE_INTERFACE_DOMAIN,MALL_CODE,self.couponModel.cid]];
    if (!shareVC) {
        shareVC = [[ShareToWeChatViewController alloc]initWithNibName:@"ShareToWeChatViewController" bundle:nil];
        shareVC.delegate = self;
        [self.view addSubview:shareVC.view];
        shareVC.view.frame = CGRectMake(0, DeviceHeight, 320, DeviceHeight);
    }
    [shareVC showView];
}
-(void)hiddenShareView:(UIViewController *)vc{
    [UIView animateWithDuration:0.3 animations:^(void){
        CGRect frame = vc.view.frame;
        frame.origin.y += DeviceHeight;
        vc.view.frame = frame;
    }];
}

@end
