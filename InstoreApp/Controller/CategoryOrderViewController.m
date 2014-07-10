//
//  CategoryOrderViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CategoryOrderViewController.h"

@interface CategoryOrderViewController ()

@end

@implementation CategoryOrderViewController

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
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *str = [self.list objectAtIndex:indexPath.row];
    if ([str isEqualToString:self.nowSelectedString]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = str;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(categoryOrderViewControllerHaveSelectedCategory:)]) {
        [_delegate categoryOrderViewControllerHaveSelectedCategory:[self.list objectAtIndex:indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setList:(NSArray *)list{
    [_list release];
    _list = [list retain];
    
    [self.myTableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    self.list = nil;
    self.delegate = nil;
    
    [_myTableView release];
    [super dealloc];
}
@end
