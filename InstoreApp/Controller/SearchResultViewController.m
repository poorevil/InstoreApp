//
//  SearchResultViewController.m
//  InstoreApp
//
//  Created by evil on 14-5-18.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SearchResultViewController.h"
#import "YouhuiTileView.h"
#import "SearchInterface.h"
#import "CouponModel.h"
#import "FoodItemCell.h"
#import "CouponView_focusedCell.h"


@interface SearchResultViewController () <UISearchBarDelegate,SearchInterfaceDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) SearchInterface *searchInterface;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger totalCount;
@property (assign, nonatomic) NSInteger everyPageCount;

@property (retain, nonatomic) NSArray *storeList;

@end

@implementation SearchResultViewController

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
    
    [self initViews];
    
    self.searchInterface = [[[SearchInterface alloc] init] autorelease];
    self.searchInterface.delegate = self;
    [self loadDataSource];
    
    self.currentPage = 1;
    self.everyPageCount = 10;
}

-(void)initViews
{
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f green:40.0f/255.0f blue:53.0f/255.0f alpha:1]];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    cancelBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelBtn;
    
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];
    self.searchBar.placeholder = @"请输入关键词";
    self.searchBar.text = self.searchKeyWord;
    self.searchBar.delegate = self;
    
    [self.searchBar setTintColor:[UIColor lightGrayColor]];
    [self.searchBar sizeToFit];
    
    self.navigationItem.titleView = self.searchBar;
    
    
    self.items = [NSMutableArray array];
    self.currentPage = 1;
    self.title = @"我的优惠劵";

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshTable
{
    [self.items removeAllObjects];
    self.currentPage = 1;
    [self loadDataSource];

    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.storeList.count == 0 ? 0 : 1;
            break;
        case 1:
            return self.storeList.count;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return ceil(self.items.count / 2.0);
            break;
        default:
            return 0;
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 44;
            break;
        case 1:
            return 80;
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 236;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
                cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
            }
            cell.textLabel.text = @"品牌";
            return cell;
        }
            break;
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
                cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
            }
            cell.textLabel.text = @"优惠";
            return cell;
        }
            break;
        case 1:{
            if (self.storeList.count > 0) {
                static NSString *CellIdentifier = @"FoodItemCell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
                }
                StoreModel *store = [self.storeList objectAtIndex:indexPath.row];
                FoodItemCell *fic = (FoodItemCell*)cell;
                fic.storeModel = store;
                return cell;
            }
        }
            break;
        case 3:{
            static NSString *CellIdentifier = @"CouponView_focusedCell";
            CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
                cell.addSecondView = YES;
//                cell.
            }
            cell.cm1 = [self.items objectAtIndex:indexPath.row * 2];
            if (self.items.count <= indexPath.row * 2 +1) {
                cell.cm2 = nil;
            }else{
                cell.cm2 = [self.items objectAtIndex:(indexPath.row * 2 + 1)];
            }
            
            //上拉加载更多
            if (indexPath.row == ceil(self.items.count / 2.0)-1) {
                if (self.currentPage * self.everyPageCount < self.totalCount) {
                    self.currentPage++;
                    [self loadDataSource];
                }
                
            }
            
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        //品牌  其他不用点
        
    }
}



//获取接口数据
- (void)loadDataSource {    
    [self.searchInterface searchKeyword:self.searchKeyWord
                                   type:0
                                orderBy:nil
                                 amount:self.everyPageCount page:self.currentPage];
}


#pragma mark - SearchInterfaceDelegate
-(void)searchDidFinished:(NSDictionary *)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
{
    [self.items addObjectsFromArray:[result objectForKey:@"couponList"]];
    self.storeList = [result objectForKey:@"storeList"];
    self.totalCount = totalAmount;
    [self.myTableView reloadData];
}

-(void)searchDidFailed:(NSString*)errorMessage
{
    DebugLog(@"%@",errorMessage);
}

#pragma mark - private method
-(void)cancelAction
{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
        [self.navigationItem.rightBarButtonItem setTitle:@"关闭"];
    }else{
//        [self dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.navigationItem.rightBarButtonItem setTitle:@"取消"];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    self.searchKeyWord = self.searchBar.text;
    [self refreshTable];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

-(void)dealloc
{
    self.items = nil;
    self.searchKeyWord = nil;
//    self.collectionView = nil;
    self.searchBar = nil;
    self.searchInterface.delegate = nil;
    self.searchInterface = nil;
    
    [_myTableView release];
    [super dealloc];
}
@end
