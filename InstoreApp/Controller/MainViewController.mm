//
//  MainViewController.m
//  InstoreApp
//
//  Created by han chao on 14-3-17.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainViewController.h"

#import "MainViewNavigationCell.h"
#import "MainViewOtherCell.h"
#import "CycleScrollView.h"
#import "MainViewMiaoShaCell.h"

#import <ZXingWidgetController.h>
#import <QRCodeReader.h>

#import "MainViewInterface.h"
#import "MainView_CategoryCell.h"
#import "MainView_StoreCell.h"

//#import "PhotoViewController.h"
#import "CouponModel.h"
#import "EGOImageView.h"
#import "LunBoImageInterface.h"
#import "WebViewController.h"

#import "GroupBuyDetailViewController.h"
#import "CouponDetailViewController.h"
#import "MallNewsDetailViewController.h"
#import "AppDelegate.h"
#import "SearchViewController.h"

//#import "MultiFormatOneDReader.h"

@interface MainViewController () <ZXingDelegate, MainViewInterfaceDelegate,LunBoImageInterfaceDelegate>
@property (nonatomic,strong) CycleScrollView *lunboView;

@property (nonatomic, retain) NSArray *itemList;
@property (nonatomic, retain) MainViewInterface *mainViewInterface;

@property (retain, nonatomic) NSArray *itemLuoBoImageList;
@property (retain, nonatomic) LunBoImageInterface *lunBoImageInterface;

@end

@implementation MainViewController

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
    
    [self initNavigationView];
//    [self initLunboView];
    self.mtableView.scrollsToTop = YES;
    
    self.mainViewInterface = [[[MainViewInterface alloc] init] autorelease];
    self.mainViewInterface.delegate = self;
    [self.mainViewInterface getMainViewList];
    
    self.itemLuoBoImageList = [NSArray array];
    self.lunBoImageInterface = [[[LunBoImageInterface alloc]init] autorelease];
    self.lunBoImageInterface.delegate = self;
    [self.lunBoImageInterface getLunBoImageListWithPos:1];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
//    self.navigationController.navigationBarHidden = YES;
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - private method
-(void)initNavigationView
{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)]autorelease];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageViewIcon = [[UIImageView alloc]initWithFrame:CGRectMake(18, 0, 25, 25)];
    imageViewIcon.image = [UIImage imageNamed:@"nav_icon.png"];
    [view addSubview:imageViewIcon];
    [imageViewIcon release];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 28, 40, 16)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"智慧商场";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor colorWithRed:238/255.0 green:76/255.0 blue:76/255.0 alpha:1];
    [view addSubview:label];
    [label release];
    
    UIImageView *imageSearchBG = [[UIImageView alloc]initWithFrame:CGRectMake(70, 9, 180, 27)];
    imageSearchBG.image = [UIImage imageNamed:@"nav_search_bg.png"];
    [view addSubview:imageSearchBG];
    [imageSearchBG release];
    
    UIImageView *imageSearchIcon = [[UIImageView alloc]initWithFrame:CGRectMake(81, 16, 14, 14)];
    imageSearchIcon.image = [UIImage imageNamed:@"nav_search_gray.png"];
    [view addSubview:imageSearchIcon];
    [imageSearchIcon release];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(102, 13, 142, 20)];
    textField.placeholder = @"输入品牌、商户、优惠";
    textField.font = [UIFont systemFontOfSize:14];
    textField.borderStyle = UITextBorderStyleNone;
    [view addSubview:textField];
    [textField release];
    
    UIButton *btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(63, 3, 195, 37);
    [btnSearch addTarget:self action:@selector(showSearchView:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnSearch];
    
    UIButton *btnScanCode = [UIButton buttonWithType:UIButtonTypeCustom];
    btnScanCode.frame = CGRectMake(260, 0, 44, 44);
    [btnScanCode setImage:[UIImage imageNamed:@"nav_scan_qrcode.png"] forState:UIControlStateNormal];
    [btnScanCode addTarget:self action:@selector(scanQRCode:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnScanCode];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.titleView = view;
}

-(void)initLunboView
{
    NSMutableArray *viewsArray = [NSMutableArray array];
    if (self.itemLuoBoImageList.count > 0) {
        for (int i = 0 ; i < self.itemLuoBoImageList.count; i++) {
            CouponModel *couponModel = [self.itemLuoBoImageList objectAtIndex:i];
            
            EGOImageView *egoImageView = [[[EGOImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)]autorelease];
            egoImageView.contentMode = UIViewContentModeScaleAspectFit;
            egoImageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/640*640.png",couponModel.imageUrl]];
            
            [viewsArray addObject:egoImageView];
        }
    }
    
    self.lunboView = [[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)
                                           animationDuration:5] autorelease];
    self.lunboView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.lunboView.totalPagesCount = ^NSInteger(void){
        return self.itemLuoBoImageList.count;
    };
    self.lunboView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",pageIndex);
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;

        
        CouponModel *couponModel = [self.itemLuoBoImageList objectAtIndex:pageIndex];
        int itemType = couponModel.itemType;
        switch (itemType) {
            case 1:
            {
                [nav.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f green:40.0f/255.0f blue:53.0f/255.0f alpha:1]];
                [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
                
                int promotionType = couponModel.promotionType;
                //优惠
                switch (promotionType) {
                    case 1:
                    {
                        //优惠活动
                        WebViewController *webVC = [[WebViewController alloc]init];
                        webVC.hidesBottomBarWhenPushed = YES;
                        webVC.urlStr = couponModel.link;
                        webVC.titleStr = @"优惠详情";
                        [self.navigationController pushViewController:webVC animated:YES];
                        [webVC release];
                    }
                        break;
                    case 2:
                    {
                        //优惠券
                        CouponDetailViewController *coupnDVC = [[CouponDetailViewController alloc]init];
                        coupnDVC.couponModel = couponModel;
                        coupnDVC.couponModel.cid = couponModel.itemId;
                        coupnDVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:coupnDVC animated:YES];
                        [coupnDVC release];
                    }
                        break;
                    case 3:
                    {
                        //团购
                        GroupBuyDetailViewController *groupBuyDVC = [[GroupBuyDetailViewController alloc]init];
                        groupBuyDVC.couponModel = couponModel;
                        groupBuyDVC.couponModel.cid = couponModel.itemId;
                        groupBuyDVC.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:groupBuyDVC animated:YES];
                        [groupBuyDVC release];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
                break;
            case 2:
            {
                //商户
            }
                break;
            case 3:
            {
                //商品
            }
                break;
            case 4:
            {
                //网页
                
                [nav.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f green:40.0f/255.0f blue:53.0f/255.0f alpha:1]];
                [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
                
                WebViewController *webVC = [[WebViewController alloc]init];
                webVC.hidesBottomBarWhenPushed = YES;
                webVC.urlStr = couponModel.link;
                webVC.titleStr = @"优惠详情";
                [self.navigationController pushViewController:webVC animated:YES];
                [webVC release];
            }
                break;
            default:
                break;
        }
    };
    
    self.mtableView.tableHeaderView = self.lunboView;

}

-(IBAction)scanQRCode:(id)sender
{
    //二维码
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:YES];
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    [qrcodeReader release];
    widController.readers = readers;
    [readers release];
    [self presentViewController:widController animated:YES completion:nil];
    [widController release];

}
-(IBAction)showSearchView:(id)sender;
{
    [super showSearchView];
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemList.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    if (indexPath.row == 0) {
        cellIdentifier = @"MainViewNavigationCell";
    }else{
        NSDictionary *dict = [self.itemList objectAtIndex:indexPath.row-1];
        cellIdentifier = [dict objectForKey:@"dataSource"];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        if (indexPath.row == 0) {
            cell = [[[NSBundle mainBundle]
                     loadNibNamed:cellIdentifier owner:self options:nil] objectAtIndex:0];
        }else{
            NSDictionary *dict = [self.itemList objectAtIndex:indexPath.row-1];
            cell = [[[NSBundle mainBundle]
                     loadNibNamed:[NSString stringWithFormat:@"MainView_%@Cell",cellIdentifier]
                     owner:self options:nil] objectAtIndex:0];
            if ([cell respondsToSelector:@selector(titleLabel)]) {
                [cell titleLabel].text = [dict objectForKey:@"title"];
            }
        }
    }
    
    if (indexPath.row != 0) {
        NSDictionary *dict = [self.itemList objectAtIndex:indexPath.row-1];
        if ([cell respondsToSelector:@selector(setDataList:)]) {
            [cell setDataList:[dict objectForKey:@"data"]];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 178;
    }else{
        NSDictionary *dict = [self.itemList objectAtIndex:indexPath.row-1];
        NSString *cellIdentifier = [dict objectForKey:@"dataSource"];
        
        if ([cellIdentifier isEqualToString:@"DailyPromotion"]) {
            return 225;
        }else if ([cellIdentifier isEqualToString:@"PromotionActivity"]) {
            return 223;
        }else if ([cellIdentifier isEqualToString:@"Coupons"]) {
            return 221;
        }else if ([cellIdentifier isEqualToString:@"GroupBuying"]) {
            return 243;
        }else if ([cellIdentifier isEqualToString:@"Restaurant"]) {
            return 223;
        }else if ([cellIdentifier isEqualToString:@"Store"]) {
            return 184;
        }else if ([cellIdentifier isEqualToString:@"Category"]) {
            return 302;
        }else{
            return 10;
        }
    }
}

#pragma mark - ZXingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
//    NSLog(@"result:%@",result);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    [controller dismissViewControllerAnimated:NO completion:nil];
}

-(void)dealloc
{
    self.lunboView = nil;
    self.mtableView = nil;
    
    self.mainViewInterface.delegate = nil;
    self.mainViewInterface = nil;
    
    self.itemList = nil;
    self.itemLuoBoImageList = nil;
    
    self.lunBoImageInterface = nil;
    
    [super dealloc];
}

#pragma mark - MainViewInterfaceDelegate
-(void)getMainViewListDidFinished:(NSArray *)viewList
                       totalCount:(NSInteger)totalCount
{
    if (viewList) {
        self.itemList = viewList;
    }
    
    [self.mtableView reloadData];
}

-(void)getMainViewListDidFailed:(NSString *)errorMsg
{
    NSLog(@"%@",errorMsg);
}

#pragma mark - LunBoImageInterfaceDelegate
-(void)getLunBoImageListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount{
    self.itemLuoBoImageList = itemList;
    
    [self initLunboView];
    
    [self.mtableView reloadData];
}
-(void)getLunBoImageListDidFailed:(NSString *)errorMsg{
    NSLog(@"%@",errorMsg);
}

//- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result{
//    NSLog(@"%@",result);
//    [controller dismissModalViewControllerAnimated:YES];
//}
//- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller{
//    [controller dismissModalViewControllerAnimated:YES];
//}

@end
