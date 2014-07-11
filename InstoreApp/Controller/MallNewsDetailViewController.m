//
//  MallNewsDetailViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNewsDetailViewController.h"

#import "NSDate+DynamicDateString.h"
#import "EGOImageView.h"
#import "MallNewsDetail_oneCell.h"
#import "MallNewsDetail_twoCell.h"
#import "MallNewsDetail_threeCell.h"
#import "MallNewsDetail_fourCell.h"

#import "WebViewController.h"
#import "PhotoViewController.h"

#import "FocusInterface.h" //收藏优惠

#import "StoreDetail_RestaurantViewController.h" //商户详情
//#import "StoreModel.h"

@interface MallNewsDetailViewController ()<CouponDetailInterfaceDelegate>{
    EGOImageView *egoHeaderView;
//    UIButton *btnFocus;
}
@property (retain, nonatomic) FocusInterface *focusInterface;


@end

@implementation MallNewsDetailViewController

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
    
    self.title = @"活动详情";
    self.couponDetailInterface = [[[CouponDetailInterface alloc] init] autorelease];
    self.couponDetailInterface.delegate = self;
    if (self.couponModel) {
        [self.couponDetailInterface getCouponDetailByCouponId:self.couponModel.cid];
    }else{
        [self.couponDetailInterface getCouponDetailByCouponId:self.youhuiID];
    }
    
//    btnFocus = [UIButton buttonWithType:UIButtonTypeCustom];
//    btnFocus.frame = CGRectMake(0, 0, 28, 44);
//    [btnFocus setImage:[UIImage imageNamed:@"focus_whiteLine.png"] forState:UIControlStateNormal];
//    [btnFocus setImageEdgeInsets:UIEdgeInsetsMake(14, 5, 14, 5)];
//    [btnFocus addTarget:self action:@selector(btnFocusAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShare.frame = CGRectMake(0, 0, 28, 44);
    [btnShare setImage:[UIImage imageNamed:@"share_white.png"] forState:UIControlStateNormal];
    [btnShare setImageEdgeInsets:UIEdgeInsetsMake(13, 5, 13, 5)];
    [btnShare addTarget:self action:@selector(btnShareAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc]initWithCustomView:btnFocus];
    UIBarButtonItem *barItem2 = [[UIBarButtonItem alloc]initWithCustomView:btnShare];
    
    self.navigationItem.rightBarButtonItems = @[barItem2/*,barItem1*/];
    
    [self initHeaderView];
    
    self.focusInterface = [[[FocusInterface alloc]init]autorelease];
    
    self.hidesBottomBarWhenPushed = YES;

}

-(void)initHeaderView{
    if(!egoHeaderView){
        egoHeaderView = [[EGOImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
        egoHeaderView.imageURL = [NSURL URLWithString:self.couponModel.imageUrl];
        self.myTableView.tableHeaderView = egoHeaderView;
        egoHeaderView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagesTapAction:)];
        [egoHeaderView addGestureRecognizer:tap];
        [tap release];
    }
    if (self.couponModel.images.count > 0) {
        egoHeaderView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.couponModel.images objectAtIndex:0]]];
    }
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 36;
            break;
        case 1:
            return 72;
            break;
        case 2:
            return 50;
            break;
            case 3:
        {
//            CGSize size = [self.couponModel.descriptionStr sizeWithFont:[UIFont systemFontOfSize:14]
//                                                               constrainedToSize:CGSizeMake(280, 999)
//                                                                   lineBreakMode:NSLineBreakByWordWrapping];
            CGSize size = [self.couponModel.descriptionStr boundingRectWithSize:CGSizeMake(300, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            return size.height + 44;
        }
            break;
            
        default:
            return 0;
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 3;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"";
    switch (indexPath.section) {
        case 0:
            CellIdentifier = @"MallNewsDetail_oneCell";
            break;
        case 1:
            CellIdentifier = @"MallNewsDetail_twoCell";
            break;
        case 2:
            CellIdentifier = @"MallNewsDetail_threeCell";
            break;
        case 3:
            CellIdentifier = @"MallNewsDetail_fourCell";
            break;
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 0:
        {
            MallNewsDetail_oneCell *oneCell = (MallNewsDetail_oneCell *)cell;
            oneCell.titleLabel.text = self.couponModel.title;
            oneCell.favNumLabel.text = [NSString stringWithFormat:@"%d",self.couponModel.focusCount];
        }
            break;
        case 1:
        {
            MallNewsDetail_twoCell *twoCell = (MallNewsDetail_twoCell *)cell;
            twoCell.labDate.text = [NSString stringWithFormat:@"%@ 至 %@",
                                    [self.couponModel.startTime toDateString],
                                    [self.couponModel.endTime toDateString]];
        }
            break;
        case 2:
        {
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
                    threeCell.labName.text = self.couponModel.store.address;
                }
                    break;
                case 2:
                {
                    threeCell.iconImage.image = [UIImage imageNamed:@"Icon_phone.png"];
                    threeCell.labClass.text = @"电话";
//                    threeCell.img.hidden = YES;
                    threeCell.labName.textColor = [UIColor colorWithRed:60/255.0 green:179/255.0 blue:235/255.0 alpha:1];
                    threeCell.labName.text = self.couponModel.store.tel;
                }
                    
                default:
                    break;
            }
        }
            break;
        case 3:
        {
            MallNewsDetail_fourCell *fourCell = (MallNewsDetail_fourCell *)cell;
            CGSize size = [self.couponModel.descriptionStr boundingRectWithSize:CGSizeMake(300, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            CGRect frame = fourCell.labDetail.frame;
            frame.size.height = size.height;
            fourCell.labDetail.frame = frame;
            fourCell.labDetail.text = self.couponModel.descriptionStr;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
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
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:10086"]];
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
    [self.myTableView reloadData];
    [self initHeaderView];
    if (self.couponModel.isFocus == YES) {
        [self.btnFocus setTitle:@"已收藏" forState:UIControlStateNormal];
    }else{
        [self.btnFocus setTitle:@"收藏" forState:UIControlStateNormal];
    }
    
    //无外链时是进入浏览图片
//    if (couponModel.link) {
//        self.btnGoNext.enabled = YES;
//    }else{
//        self.btnGoNext.enabled = NO;
//    }
}

-(void)getCouponDetailDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}
-(IBAction)btnFocusAction:(UIButton *)sender{
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
-(void)btnShareAction:(UIButton *)sender{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    [_bottomView release];
    [egoHeaderView release];
    self.focusInterface = nil;
    
    [_btnFocus release];
    [super dealloc];
}
-(void)imagesTapAction:(UIGestureRecognizer *)sender
{
    PhotoViewController *photoViewController = [[[PhotoViewController alloc] init] autorelease];
    photoViewController.hidesBottomBarWhenPushed = YES;
    self.hidesBottomBarWhenPushed = YES;
    photoViewController.currentImageUrl = [self.couponModel.images objectAtIndex:0];
    photoViewController.imageListUrl = self.couponModel.images;
    
    [self.navigationController pushViewController:photoViewController animated:NO];
}
- (IBAction)btnGoNextAction:(UIButton *)sender {
    if (self.couponModel.link) {
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.urlStr = self.couponModel.link;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
        [webVC release];
    }else{
        [self imagesTapAction:nil];
    }
}
@end
