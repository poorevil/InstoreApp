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

@interface MainViewController () <ZXingDelegate>
@property (nonatomic,strong) CycleScrollView *lunboView;

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
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    scanBtn.frame = CGRectMake(0, 0, 40, 40);
    scanBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [scanBtn setTitleColor:[UIColor colorWithRed:233/255.0f
                                           green:63/255.0f
                                            blue:75/255.0f
                                           alpha:1] forState:UIControlStateNormal];
    [scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    UIImage *image = [[UIImage imageNamed:@"topBar-btn-sao"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [scanBtn setImage:image forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
    [scanBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, -image.size.width, 0, 0)];
    [scanBtn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                                 (scanBtn.frame.size.width-scanBtn.imageView.frame.size.width)/2,
                                                 (scanBtn.frame.size.height-scanBtn.imageView.frame.size.height)/2,
                                                 0)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
    self.navigationItem.rightBarButtonItem =rightBtn;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchBtn.frame = CGRectMake(0, 0, 320, 30);
    [searchBtn setTitle:@"寻找优惠券、商家" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(showSearchView) forControlEvents:UIControlEventTouchUpInside];
    
//    UIImage *originalImage = [UIImage imageNamed:@"top-search-icon"];
//    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 300);
    UIImage *stretchableImage = [UIImage imageNamed:@"top-search-icon"];//[originalImage resizableImageWithCapInsets:insets];
    [searchBtn setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    
    UIImage *searchImage = [[UIImage imageNamed:@"topBar-btn-zoom"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [searchBtn setImage:searchImage forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.navigationItem.titleView = searchBtn;
    
    [self initLunboView];
    self.mtableView.scrollsToTop = YES;
    
    [self initFooterView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(void)initLunboView
{
    NSArray *imageFileName = @[@"banner_1.jpg",@"banner_2.jpg",@"banner_3.jpg",@"banner_4.jpg",@"banner_5.jpg"];
    NSMutableArray *viewsArray = [NSMutableArray array];
    for (int i = 0; i < imageFileName.count; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        imageView.image = [UIImage imageNamed:[imageFileName objectAtIndex:i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [viewsArray addObject:imageView];
    }
    
    self.lunboView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)
                                          animationDuration:5];
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

-(void)initFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, footerView.frame.size.width, 30)];
    titleLabel.text = @"继续拖动有惊喜!";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:titleLabel];
    
    self.mtableView.tableFooterView = footerView;
    
}

-(void)scanQRCode
{
    //二维码
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
//    [qrcodeReader release];
    widController.readers = readers;
//    [readers release];
    [self presentViewController:widController animated:YES completion:nil];
//    [widController release];
}


#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    
    switch (indexPath.section) {
        case 0:
            cellIdentifier = @"MainViewNavigationCell";
            break;
        case 1:
            cellIdentifier = @"MainViewMiaoShaCell";
            break;
        case 2:
            cellIdentifier = @"MainViewYouhuiCell";
            break;
//        case 4:
//            cellIdentifier = @"MainViewSliderCell";
//            break;
//        case 5:
//            cellIdentifier = @"MainViewSliderCell";
//            break;
//        case 6:
//            cellIdentifier = @"MainViewSliderCell";
//            break;
            
        default:
            cellIdentifier = @"MainViewOtherCell";
            break;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil] objectAtIndex:0];
        
    }
    
//    cell.textLabel.text = @"aaa";
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 130;
        case 1:
            return 180;
        case 2:
            return 334;
            //        case 3:
            //            cellIdentifier = @"MainViewOtherCell";
            //            break;
            //        case 4:
            //            cellIdentifier = @"MainViewSliderCell";
            //            break;
            //        case 5:
            //            cellIdentifier = @"MainViewSliderCell";
            //            break;
            //        case 6:
            //            cellIdentifier = @"MainViewSliderCell";
            //            break;
            
        default:
            return 310;
            break;
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
//    [alert release];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"deviceId": @"deviceId111",@"portalId":@"zgdx",@"uuid":result};
//    
//    [manager POST:[NSString stringWithFormat:@"%@/regist/clientRegist",BASEURL] parameters:parameters
//          success:^(AFHTTPRequestOperation *operation, id responseObject) {
//              //{"regist_result":200,"msg":"go to login page"}
//              NSLog(@"Success: %@", responseObject);
//              
//          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              NSLog(@"Error: %@", error);
//          }];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller
{
    [controller dismissViewControllerAnimated:NO completion:nil];
}

@end