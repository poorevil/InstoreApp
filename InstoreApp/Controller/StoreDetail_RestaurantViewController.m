//
//  StoreDetail_RestaurantViewController.m
//  InstoreApp
//
//  Created by evil on 14-6-20.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreDetail_RestaurantViewController.h"
#import "StoreModel.h"

@interface StoreDetail_RestaurantViewController ()

@property (nonatomic, retain) StoreModel *storeModel;

@end

@implementation StoreDetail_RestaurantViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//5
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    switch (indexPath.section) {
        case 0:
            cellIdentifier = @"StoreDetail_headerCell";
            break;
            
        default:
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier
                                             owner:self
                                            options:nil] objectAtIndex:0];
    }
    
    return cell;
}

@end
