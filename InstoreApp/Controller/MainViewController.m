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
    
//    self.title = @"首页";
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
//    rightBtn.title = @"搜索";
//    self.navigationItem.rightBarButtonItem =rightBtn;
    
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
                                          animationDuration:2];
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
