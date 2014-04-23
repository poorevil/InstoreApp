//
//  YouhuiCategoryViewController.m
//  InstoreApp
//
//  Created by evil on 14-4-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "YouhuiCategoryViewController.h"
#import "CategoryModel.h"

@interface YouhuiCategoryViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *mtableView;
@property (nonatomic,strong) NSArray *categorys;//分类列表
@property (nonatomic,strong) CategoryModel *selectedCategoryModel;
@end

@implementation YouhuiCategoryViewController

-(id)initWithCategoryModel:(CategoryModel *)categoryModel
{
    self = [super init];
    if (self) {
        self.selectedCategoryModel = categoryModel;
    }
    
    return self;
}

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
    // Do any additional setup after loading the view.
    
    self.title = @"分类筛选";
    
    self.mtableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.mtableView.delegate = self;
    self.mtableView.dataSource = self;

    
    [self.view addSubview:self.mtableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;//self.categorys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = @"分类";//TODO:从列表中获取
    
    if (indexPath.row == 0) {//TODO:判断选中的分类id
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO:获取选中的分类
    //TODO:更新selectedCategory
    if ([self.delegate respondsToSelector:@selector(categoryDidSelected:)]) {
        [self.delegate categoryDidSelected:[[self.categorys objectAtIndex:indexPath.row] copy]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
