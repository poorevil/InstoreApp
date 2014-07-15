//
//  StoreCategoryFilterViewController.m
//  InstoreApp
//
//  Created by evil on 14-7-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreCategoryFilterViewController.h"

@interface StoreCategoryFilterViewController ()

@property (nonatomic, retain) NSArray *nameArray;
@property (nonatomic, retain) NSArray *valueArray;

@end

@implementation StoreCategoryFilterViewController

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
    self.nameArray = @[@"全部商家",@"缤纷百货",@"餐饮美食",@"休闲娱乐"];
    self.valueArray = @[@"",@"Department",@"Restaurant",@"Entertainment"];
    
    if (!self.category) {
        self.category = @"";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.mtableView = nil;
    self.category = nil;
    
    [super dealloc];
}

#pragma mark - @protocol UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"cell"] autorelease];
    }
    
    cell.textLabel.text = [self.nameArray objectAtIndex:indexPath.row];
    
    if ([self.category isEqualToString:[self.valueArray objectAtIndex:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取选中的分类
    if ([self.delegate respondsToSelector:@selector(categorySelectDidFinished:name:)]) {
        [self.delegate categorySelectDidFinished:[self.valueArray objectAtIndex:indexPath.row]
                                            name:[self.nameArray objectAtIndex:indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
