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

@interface MainViewController () <ZXingDelegate, MainViewInterfaceDelegate>
@property (nonatomic,strong) CycleScrollView *lunboView;

@property (nonatomic, retain) NSArray *itemList;
@property (nonatomic, retain) MainViewInterface *mainViewInterface;

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
    [self initLunboView];
    self.mtableView.scrollsToTop = YES;
    
    self.mainViewInterface = [[[MainViewInterface alloc] init] autorelease];
    self.mainViewInterface.delegate = self;
    [self.mainViewInterface getMainViewList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - private method
-(void)initNavigationView
{
    //扫描二维码btn
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    scanBtn.frame = CGRectMake(0, 0, 34, 34);
    UIImage *image = [[UIImage imageNamed:@"nav_scan_qrcode"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [scanBtn setImage:image forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *scanBarBtn = [[[UIBarButtonItem alloc] initWithCustomView:scanBtn] autorelease];
    
    //查询按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame = CGRectMake(0, 0, 34, 34);
    [searchBtn setImage:[[UIImage imageNamed:@"nav_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
               forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(showSearchView)
        forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBarBtn = [[[UIBarButtonItem alloc] initWithCustomView:searchBtn] autorelease];
    
    self.navigationItem.rightBarButtonItems = @[scanBarBtn, searchBarBtn];

    
    //navigation titleview
    UIView *titleView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 44)] autorelease];
    
    UIImageView *iconImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon"]] autorelease];
    iconImageView.frame = CGRectMake(0, 4, 36, 36);
    [titleView addSubview:iconImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 2, 100, 40)];
    titleLabel.textColor = [UIColor colorWithRed:248.0f/255.0f
                                           green:40.0f/255.0f
                                            blue:53.0f/255.0f
                                           alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"智慧商场";
    [titleView addSubview:titleLabel];
    
    self.navigationItem.titleView = titleView;
}

-(void)initLunboView
{
    NSArray *imageFileName = @[@"banner_1.jpg",@"banner_2.jpg",@"banner_3.jpg",@"banner_4.jpg",@"banner_5.jpg"];
    NSMutableArray *viewsArray = [NSMutableArray array];
    for (int i = 0; i < imageFileName.count; ++i) {
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)] autorelease];
        imageView.image = [UIImage imageNamed:[imageFileName objectAtIndex:i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [viewsArray addObject:imageView];
    }
    
    self.lunboView = [[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)
                                          animationDuration:5] autorelease];
    self.lunboView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    self.lunboView.totalPagesCount = ^NSInteger(void){
        return imageFileName.count;
    };
    self.lunboView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%d个",pageIndex);
    };
    
    self.mtableView.tableHeaderView = self.lunboView;

}

-(void)scanQRCode
{
    //二维码
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    [qrcodeReader release];
    widController.readers = readers;
    [readers release];
    [self presentViewController:widController animated:YES completion:nil];
    [widController release];
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
            if ([cellIdentifier isEqualToString:@"Store"]) {
                cell = [[MainView_StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                //TODO:
            }else if ([cellIdentifier isEqualToString:@"Category"]) {
                cell = [[MainView_CategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                //TODO:
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
        }
        
        //TODO:高度
    //    else if ([cellIdentifier isEqualToString:@"Category"]) {
    //        return 300;
    //    }else if ([cellIdentifier isEqualToString:@"Store"]) {
    //        return 174;
    //    }
        else{
            return 10;
        }
    }
}

#pragma mark - ZXingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result
{
    NSLog(@"result:%@",result);
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

@end
