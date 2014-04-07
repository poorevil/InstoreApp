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


@interface MainViewController ()
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
    [scanBtn setTitleEdgeInsets:UIEdgeInsetsMake(30, -image.size.width, 0, 0)];
    [scanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 10, 5)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
    self.navigationItem.rightBarButtonItem =rightBtn;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchBtn.frame = CGRectMake(0, 0, 320, 40);
    [searchBtn setTitle:@"寻找优惠券、商家" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(showSearchView) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *originalImage = [UIImage imageNamed:@"top-search-icon"];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 300);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    [searchBtn setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    
    UIImage *searchImage = [[UIImage imageNamed:@"topBar-btn-zoom"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [searchBtn setImage:searchImage forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.navigationItem.titleView = searchBtn;
    
    [self initLunboView];
    self.mtableView.scrollsToTop = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(void)initLunboView
{
    NSArray *imageFileName = @[@"coffee.jpg",@"banner.jpg",@"banner2.jpg",@"wifi1.jpg",@"url.jpg"];
    NSMutableArray *viewsArray = [NSMutableArray array];
    for (int i = 0; i < imageFileName.count; ++i) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        imageView.image = [UIImage imageNamed:[imageFileName objectAtIndex:i]];
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

-(void)scanQRCode
{
    
}


#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 15;
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

@end
