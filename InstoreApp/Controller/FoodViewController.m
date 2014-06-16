//
//  FoodViewController.m
//  InstoreApp
//
//  Created by evil on 14-6-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FoodViewController.h"

#import "CycleScrollView.h"
#import "FoodSectionCell.h"

@interface FoodViewController ()
@property (nonatomic,strong) CycleScrollView *lunboView;

@property (nonatomic, retain) NSMutableArray *itemList;

@end

@implementation FoodViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initLunboView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.lunboView = nil;
    self.mtableView = nil;
    
    self.itemList = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)initLunboView
{
    NSArray *imageFileName = @[@"banner_1.jpg",@"banner_2.jpg",@"banner_3.jpg",@"banner_4.jpg",@"banner_5.jpg"];
    NSMutableArray *viewsArray = [NSMutableArray array];
    for (int i = 0; i < imageFileName.count; ++i) {
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
        imageView.image = [UIImage imageNamed:[imageFileName objectAtIndex:i]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [viewsArray addObject:imageView];
    }
    
    self.lunboView = [[[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"FoodSectionCell";
    
    if (indexPath.row != 0) {
        cellIdentifer = @"FoodItemCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifer
                                             owner:self
                                           options:nil] objectAtIndex:0];
    }
    
    if (![cellIdentifer isEqualToString:@"FoodSectionCell"]) {
        //TODO:
    }
    
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 52;
    }else{
        return 80;
    }
}

@end
