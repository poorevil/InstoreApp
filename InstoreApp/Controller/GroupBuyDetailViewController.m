//
//  GroupBuyDetailViewController.m
//  InstoreApp
//
//  Created by evil on 14-6-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "GroupBuyDetailViewController.h"
#import "EGOImageView.h"
#import "CouponModel.h"
#import "StoreModel.h"
#import "PhotoViewController.h"

#import "GroupBuyDetailPriceCell.h"
#import "GroupBuyDetailCardCell.h"
#import "GroupBuyDateTimeCell.h"
#import "CouponDetailStoreCell.h"
#import "GroupBuyRecommendCell.h"
#import "MallNewsDetail_threeCell.h"

#import "NSDate+DynamicDateString.h"

#import "CouponDetailInterface.h"
#import "FocusInterface.h"
#import "WebViewController.h"

//#import "UIViewController+ShareToWeChat.h"
#import "ShareToWeChatViewController.h"

#import "StoreDetail_RestaurantViewController.h"
#import "BankCardModel.h"


@interface GroupBuyDetailViewController () <UITableViewDataSource, UITableViewDelegate,
CouponDetailInterfaceDelegate,ShareToWeChatDeleate>{
    ShareToWeChatViewController *shareVC;
}
@property (nonatomic,strong) UIView *headerView;

@property (nonatomic,strong) EGOImageView *headerImageView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) CouponDetailInterface *couponDetailInterface;
@property (retain, nonatomic) FocusInterface *focusInterface;

@end

@implementation GroupBuyDetailViewController

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
    
    self.title = @"团购详情";
    
    self.couponDetailInterface = [[[CouponDetailInterface alloc] init] autorelease];
    self.couponDetailInterface.delegate = self;
    [self.couponDetailInterface getCouponDetailByCouponId:self.couponModel.cid];
    
    [self initHeaderView];
    
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

-(void)dealloc
{
    self.couponModel = nil;
    self.mtableView = nil;
    
    self.headerView = nil;
    self.headerImageView = nil;
    self.titleLabel = nil;
    
    self.couponDetailInterface.delegate = nil;
    self.couponDetailInterface = nil;
    
    self.focusInterface = nil;
    
    [_btnFocus release];
    [_btnGoNext release];
    [super dealloc];
}

#pragma mark - private method
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
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0,
                                                                     titleGroupView.bounds.size.width,
                                                                     titleGroupView.bounds.size.height)] autorelease];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.text = self.couponModel.title;
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

-(void)refreshUI
{
    [self.mtableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;//价格
        case 1:
            return 1;//银行卡
        case 2:
            return 1;//段描述
        case 3:
            return 1;//剩余时间
        case 4:
            return 1;//购买须知
        case 5:
            return 3;
            
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
            return 53;
        case 3:
            return 68;
        case 4:{
            //计算内容的size
            CGSize labelFontSize = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                               constrainedToSize:CGSizeMake(300, 999)
                                                                   lineBreakMode:NSLineBreakByWordWrapping];
            return labelFontSize.height+45;
        }
        case 5:
            return 50;
        default:
            return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    
    switch (indexPath.section) {
        case 0:
            cellIdentifier = @"GroupBuyDetailPriceCell";
            break;
        case 1:
            cellIdentifier = @"GroupBuyDetailCardCell";
            break;
        case 2:
            cellIdentifier = @"cell";//短描述
            break;
        case 3:
            cellIdentifier = @"GroupBuyDateTimeCell";
            break;
        case 4:
            cellIdentifier = @"GroupBuyDateTimeCell";
            break;
        case 5:
            cellIdentifier = @"MallNewsDetail_threeCell";
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
            cell.textLabel.numberOfLines = 2;
        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self
                                                options:nil] objectAtIndex:0];
        }
    }
    
    switch (indexPath.section) {
        case 0:{
            GroupBuyDetailPriceCell *gbdp = (GroupBuyDetailPriceCell *)cell;
            gbdp.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.couponModel.price];
            CGSize labelFontSize = [gbdp.priceLabel.text sizeWithFont:gbdp.priceLabel.font
                                                      constrainedToSize:CGSizeMake(gbdp.priceLabel.frame.size.width*2,
                                                                                   gbdp.priceLabel.frame.size.height)
                                                          lineBreakMode:gbdp.priceLabel.lineBreakMode];
            gbdp.priceLabel.frame = CGRectMake(gbdp.priceLabel.frame.origin.x,
                                                 gbdp.priceLabel.frame.origin.y,
                                                 labelFontSize.width,
                                                 gbdp.priceLabel.frame.size.height);

            
            gbdp.oldPriceLabel.text = self.couponModel.oldPrice;
            CGSize oldPriceLabelSize = [gbdp.oldPriceLabel.text sizeWithFont:gbdp.oldPriceLabel.font
                                                    constrainedToSize:CGSizeMake(gbdp.oldPriceLabel.frame.size.width*2,
                                                                                 gbdp.oldPriceLabel.frame.size.height)
                                                        lineBreakMode:gbdp.oldPriceLabel.lineBreakMode];
            gbdp.oldPriceLabel.frame = CGRectMake(gbdp.priceLabel.frame.size.width + gbdp.priceLabel.frame.origin.x,
                                                  gbdp.oldPriceLabel.frame.origin.y,
                                                  oldPriceLabelSize.width,
                                                  gbdp.oldPriceLabel.frame.size.height);

            gbdp.oldPriceLabel.isWithStrikeThrough = YES;
            
            gbdp.amountLabel.text = [NSString stringWithFormat:@"%d人已购买",self.couponModel.collectCount];
            
            
            
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
            cell.textLabel.textColor = [UIColor colorWithRed:79/255.0 green:79/255.0 blue:79/255.0 alpha:1];
            if (self.couponModel.shortTitle) {
                cell.textLabel.text = self.couponModel.shortTitle;
            }else{
                cell.textLabel.text = @"暂时没有介绍";
            }
            break;
        case 3:
            if ([cell isMemberOfClass:[GroupBuyDateTimeCell class]]) {
                GroupBuyDateTimeCell *withTitleCell = (GroupBuyDateTimeCell *)cell;
                withTitleCell.titleLabel.text = @"剩余时间";
                withTitleCell.iconImageView.image = [UIImage imageNamed:@"couponview_focus_time"];
                
                NSString *str = [self.couponModel.endTime distanceFromNowMaxSeconds:60*60*24
                                                                         RelpaceStr:[self.couponModel.endTime toDateString]
                                                                          perfixStr:nil];
                withTitleCell.dateLabel.text = str?str:@"已过期";
            }
            break;
        case 4:
            if ([cell isMemberOfClass:[GroupBuyDateTimeCell class]]) {
                GroupBuyDateTimeCell *withTitleCell = (GroupBuyDateTimeCell *)cell;
                withTitleCell.titleLabel.text = @"购买须知";
                withTitleCell.iconImageView.image = [UIImage imageNamed:@"groupbuy_memo"];
                withTitleCell.dateLabel.text = self.couponModel.descriptionStr;
                
                withTitleCell.dateLabel.numberOfLines = 0;
                //计算内容的size
                CGSize labelFontSize = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14]
                                                                   constrainedToSize:CGSizeMake(300, 999)
                                                                       lineBreakMode:withTitleCell.dateLabel.lineBreakMode];
                
                withTitleCell.dateLabel.frame = CGRectMake(withTitleCell.dateLabel.frame.origin.x,
                                                             withTitleCell.dateLabel.frame.origin.y,
                                                             300,
                                                             labelFontSize.height);
                withTitleCell.frame = CGRectMake(0, 0, withTitleCell.frame.size.width,
                                                 withTitleCell.dateLabel.frame.size.height+45);
            }
            break;
        case 5:{
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
                }
            }
        }
            break;

        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 5) {
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
    }else{
        [self.btnFocus setTitle:@"收藏" forState:UIControlStateNormal];
    }
    if (!(couponModel.link.length > 0)) {
        self.btnGoNext.hidden = YES;
        self.btnFocus.frame = CGRectMake(110, 8, 100, 28);
    }
}

-(void)getCouponDetailDidFailed:(NSString *)errorMessage
{
    DebugLog(@"%@",errorMessage);
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
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.urlStr = self.couponModel.link;
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
    [webVC release];
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
