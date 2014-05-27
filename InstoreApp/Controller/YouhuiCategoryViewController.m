//
//  YouhuiCategoryViewController.m
//  InstoreApp
//
//  Created by evil on 14-4-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "YouhuiCategoryViewController.h"
#import "CategoryModel.h"

#import "CategoryListInterface.h"

@interface YouhuiCategoryViewController () <UITableViewDataSource,UITableViewDelegate,CategoryListInterfaceDelegate>

@property (nonatomic,strong) UITableView *mtableView;
@property (nonatomic,strong) NSMutableArray *categorys;//分类列表
@property (nonatomic,strong) CategoryModel *selectedCategoryModel;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) CategoryListInterface *categoryInterface;
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
    
    self.currentPage = 1;
    self.title = @"分类筛选";
    
    self.categorys = [NSMutableArray array];
    
    self.mtableView = [[[UITableView alloc] initWithFrame:self.view.bounds] autorelease];
    self.mtableView.delegate = self;
    self.mtableView.dataSource = self;

    [self.view addSubview:self.mtableView];
    
    self.categoryInterface = [[[CategoryListInterface alloc] init] autorelease];
    self.categoryInterface.delegate = self;
    [self.categoryInterface getCategoryListByPage:self.currentPage
                                           amount:20];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.categorys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CategoryModel *cm = [self.categorys objectAtIndex:indexPath.row];
    cell.textLabel.text = cm.cName;
    
    if (self.selectedCategoryModel.cid == cm.cid) {
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
    if ([self.delegate respondsToSelector:@selector(categoryDidSelected:)]) {
        [self.delegate categoryDidSelected:[self.categorys objectAtIndex:indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - CategoryInterfaceDelegate <NSObject>

-(void)getCategoryListDidFinished:(NSArray *)categoryList totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage
{
    [self.categorys addObjectsFromArray:categoryList];
    [self.mtableView reloadData];
    
    self.currentPage++;
}

-(void)getCategoryListDidFailed:(NSString *)errorMessage
{
    NSLog(@"%@",errorMessage);
}

-(void)dealloc
{
    self.delegate = nil;
    
    self.mtableView = nil;
    self.categorys = nil;
    self.selectedCategoryModel = nil;
    self.categoryInterface.delegate = nil;
    self.categoryInterface = nil;
    
    [super dealloc];
}

@end
