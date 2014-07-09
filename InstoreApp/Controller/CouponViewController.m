//
//  CouponViewController.m
//  InstoreApp
//
//  Created by hanchao on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponViewController.h"
#import "CategoryModel.h"

#import "CouponviewInterface.h"
#import "CouponSectionTwoInterface.h"
#import "CouponSearchOrderInterface.h"

#import "CouponView_titleCell.h"
#import "CouponView_focusedCell.h"
#import "CouponView_empty2_Cell.h"

#import "YouhuiCategoryViewController.h"
#import "YouHuiOrderViewController.h"


@interface CouponViewController () <UITableViewDataSource, UITableViewDelegate,
CouponViewInterfaceDelegate, YouhuiCategoryViewControllerDelegate,YouHuiOrderViewControllerDelegate,CouponSectionTwoInterfaceDelegate,CouponSearchOrderInterfaceDelegate>

@property (nonatomic, retain) NSMutableDictionary *itemListDict;//关注的商户的优惠集合
@property (nonatomic, retain) NSDictionary *otherGroupDict;//其他组内容集合

//@property (nonatomic, assign) NSInteger listTotalCount;//关注的商户的优惠总数
//@property (nonatomic, retain) NSArray *otherGroupKeysOrder;//其他组的顺序，记录了所有key的名字
//@property (nonatomic, assign) NSInteger currentPage;//当前页
@property (nonatomic, assign) NSInteger focusCount;//用户收藏的优惠数量

@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件

@property (nonatomic, retain) CouponViewInterface *couponViewInterface; //收藏接口
@property (retain, nonatomic) CouponSectionTwoInterface *couponSectionTwoInterface;
@property (retain, nonatomic) CouponSearchOrderInterface *couponSearchOrderInterface;

@property (retain, nonatomic) NSMutableArray *itemList;
@property (retain, nonatomic) NSMutableArray *itemList2;
@property (retain, nonatomic) NSMutableArray *itemListAll;
@property (assign, nonatomic) NSInteger currentPageAll;
@property (assign, nonatomic) NSInteger currentPage1;
@property (assign, nonatomic) NSInteger currentPage2;
@property (assign, nonatomic) NSInteger totalCountAll;
@property (assign, nonatomic) NSInteger totalCount1;
@property (assign, nonatomic) NSInteger totalCount2;

@property (assign, nonatomic) BOOL isOrder;
@property (assign, nonatomic) NSInteger cid;
@property (assign, nonatomic) NSInteger type;
@property (retain, nonatomic) NSString *order;


@end

@implementation CouponViewController

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
    
    self.currentPageAll = 1;
    self.currentPage1 = 1;
    self.currentPage2 = 1;
    
    self.title = @"优惠";
    
    self.itemList = [NSMutableArray array];
    self.itemList2 = [NSMutableArray array];
    self.itemListAll = [NSMutableArray array];
    
    self.couponViewInterface = [[[CouponViewInterface alloc] init] autorelease];
    self.couponViewInterface.delegate = self;
    [self.couponViewInterface getCouponViewListByPage:self.currentPage1 amount:20];
    
    self.couponSectionTwoInterface = [[CouponSectionTwoInterface alloc]init];
    self.couponSectionTwoInterface.delegate = self;
    [self.couponSectionTwoInterface getCouponSectionTwoListByPage:self.currentPage2 amount:20];
    
    self.couponSearchOrderInterface = [[CouponSearchOrderInterface alloc]init];
    self.couponSearchOrderInterface.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.typeBtn = nil;
    self.orderBtn = nil;
    self.mtableView = nil;
    self.couponSearchOrderInterface = nil;
    self.couponViewInterface = nil;
    self.couponSectionTwoInterface = nil;
    self.itemListDict = nil;
    self.otherGroupDict = nil;
//    self.otherGroupKeysOrder = nil;
    self.filterCategory = nil;
    self.itemList = nil;
    self.itemList2 = nil;
    self.itemListAll = nil;
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource<NSObject>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isOrder) {
        return 1;
    }else{
        return 4;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOrder) {
        return ceil(self.itemListAll.count /2.0);
    }else{
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return ceil((self.itemList.count +1 ) / 2.0);
                break;
            case 2:
                return 1;
                break;
            case 3:
                return ceil(self.itemList2.count / 2.0);
                break;
            default:
                return 0;
                break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isOrder) {
        return 236;
    }else{
        switch (indexPath.section) {
            case 0:
            case 2:
                return 44;
                break;
            case 1:
                if (indexPath.row == ceil((self.itemList.count +1 ) / 2)) {
                    return 120;
                }else{
                    return 236;
                }
                break;
            case 3:
                return 236;
                break;
            default:
                return 236;
                break;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOrder == NO) {
        switch (indexPath.section) {
            case 1:
            {
                if (self.itemList.count % 2 == 0) {
                    if (self.itemList.count < (indexPath.row * 2 + 1)) {
                        static NSString *CellIdentifier = @"CouponView_empty2_Cell";
                        CouponView_empty2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                        if (!cell) {
                            cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_empty2_Cell" owner:self options:nil] objectAtIndex:0];
                        }
                        return cell;
                    }
                }else/* if(indexPath.row == 3)*/{
                    static NSString *CellIdentifier = @"CouponView_focusedCell";
                    CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
                    }
                    cell.cm1 = [self.itemList objectAtIndex:indexPath.row * 2];
                    if (self.itemList.count < indexPath.row * 2 +1) {
                        cell.cm2 = nil;
                    }else{
                        cell.cm2 = [self.itemList objectAtIndex:(indexPath.row * 2 + 1)];
                    }
                    return cell;
                    //            }else{
                    //                
                }
            }
                break;
            case 3:
            {
                static NSString *CellIdentifier = @"CouponView_focusedCell";
                CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
                }
                cell.cm1 = [self.itemList2 objectAtIndex:indexPath.row * 2];
                if (self.itemList2.count < indexPath.row * 2 +1) {
                    cell.cm2 = nil;
                }else{
                    cell.cm2 = [self.itemList2 objectAtIndex:(indexPath.row * 2 + 1)];
                }
                return cell;
            }
                break;
            case 0:
            {
                static NSString *CellIdentifier = @"CouponView_titleCell";
                CouponView_titleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_titleCell"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
                }
                cell.titleLabel.text = @"收藏商品的优惠";
                return cell;
            }
                break;
            case 2:
            {
                static NSString *CellIdentifier = @"CouponView_titleCell";
                CouponView_titleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_titleCell"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
                }
                cell.titleLabel.text = @"可能感兴趣的优惠";
                return cell;
            }
                break;
            default:
                return nil;
                break;
        }
    }
    static NSString *CellIdentifier = @"CouponView_focusedCell";
    CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.cm1 = [self.itemListAll objectAtIndex:indexPath.row * 2];
    if (self.itemListAll.count < indexPath.row * 2 +1) {
        cell.cm2 = nil;
    }else{
        cell.cm2 = [self.itemListAll objectAtIndex:(indexPath.row * 2 + 1)];
    }
    return cell;
/*    NSString *CellIdentifier = [self getCellIdentifier:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (self.isOrder) {  //排序后
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
        }
        CouponView_focusedCell *myCell = (CouponView_focusedCell *)cell;
        myCell.cm1 = [self.itemListAll objectAtIndex:indexPath.row * 2];
        myCell.cm2 = [self.itemListAll objectAtIndex:(indexPath.row * 2 + 1)];
        return myCell;
    }else{   //排序前，分2组
        if (indexPath.section == 0) { //组1
            if (self.itemList.count % 2 == 0) { //"添加收藏"样式
                if (indexPath.row == ceil((self.itemList.count +1)/ 2)) {
                    //“添加收藏”为整行的时候
                    if (!cell) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_empty2_Cell" owner:self options:nil] objectAtIndex:0];
                    }
                    return cell;
                }
            }
//            else{
//                if (indexPath.row == ceil((self.itemList.count)/ 2)) {
//                    if (!cell) {
//                        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
//                    }
//                    CouponView_focusedCell *myCell = (CouponView_focusedCell *)cell;
//                    myCell.cm1 = [self.itemListAll objectAtIndex:indexPath.row * 2];
//                    myCell.cm2 = nil;
//                    return myCell;
//                }else{
//                    if (!cell) {
//                        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
//                    }
//                    CouponView_focusedCell *myCell = (CouponView_focusedCell *)cell;
//                    myCell.cm1 = [self.itemListAll objectAtIndex:indexPath.row * 2];
//                    myCell.cm2 = [self.itemListAll objectAtIndex:(indexPath.row * 2 + 1)];
//                    return myCell;
//                }
//            }
        }else{
            //组2
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
            }
            CouponView_focusedCell *myCell = (CouponView_focusedCell *)cell;
            myCell.cm1 = [self.itemListAll objectAtIndex:indexPath.row * 2];
            myCell.cm2 = [self.itemListAll objectAtIndex:(indexPath.row * 2 + 1)];
            return myCell;
        }
    }
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
    }
    CouponView_focusedCell *myCell = (CouponView_focusedCell *)cell;
    myCell.cm1 = [self.itemListAll objectAtIndex:indexPath.row * 2];
    myCell.cm2 = [self.itemListAll objectAtIndex:(indexPath.row * 2 + 1)];
    return myCell;
 */
}


#pragma mark - CouponViewInterfaceDelegate <NSObject>
- (void)getCouponViewListDidFinished:(NSArray *)resultArray
                          focusCount:(NSInteger)focusCount
                          totalCount:(NSInteger)totalCount
                         currentPage:(NSInteger)currentPage
{
    /*
    self.listTotalCount = totalCount;
    self.focusCount = focusCount;
    
    if (self.currentPage == 1) {
        self.otherGroupDict = resultDict;
        self.otherGroupKeysOrder = [resultDict objectForKey:@"otherGroupKeysOrder"];
        self.itemListDict = [self.otherGroupDict objectForKey:@"list"];
    }else{
        //其他页只返回关注的商户的优惠集合
        [[self.itemListDict objectForKey:@"itemlist"] addObjectsFromArray:[resultDict objectForKey:@"list"]];
    }
    
    self.currentPage ++;
    
    [self.mtableView reloadData];
    */
    self.totalCount1 = totalCount;
    self.currentPage1 = currentPage;
    self.currentPage1++;
    
    [self.itemList addObjectsFromArray:resultArray];
    
    [self.mtableView reloadData];
}

- (void)getCouponViewListDidFailed:(NSString *)errorMsg
{
    NSLog(@"%@",errorMsg);
}

#pragma mark - CouponSectionTwoInterfaceDelegate
- (void)getCouponSectionTwoListDidFinished:(NSArray *)resultArray focusCount:(NSInteger)focusCount totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    self.totalCount2 = totalCount;
    self.currentPage2 = currentPage;
    self.currentPage2++;
    
    [self.itemList2 addObjectsFromArray:resultArray];
    
    [self.mtableView reloadData];
}
- (void)getCouponSectionTwoListDidFailed:(NSString *)errorMsg{
   NSLog(@"%@",errorMsg);
}
    
#pragma mark - CouponSearchOrderInterfaceDelegate
-(void)couponSearchOrderDidFinished:(NSArray*)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage{
    [self.itemListAll addObjectsFromArray:result];
    self.totalCountAll = totalAmount;
    self.currentPageAll = currentPage;
    self.currentPageAll++;
    
    [self.mtableView reloadData];
    [self.mtableView scrollRectToVisible:CGRectMake(0, 0, 320, 1) animated:YES];
}
-(void)couponSearchOrderDidFailed:(NSString*)errorMessage{
    NSLog(@"%s:%@",__FUNCTION__,errorMessage);
}

#pragma mark - YouhuiCategoryViewControllerDelegate
-(void)categoryDidSelected:(CategoryModel *)categoryModel
{
    self.filterCategory = categoryModel;
    if (self.filterCategory) {
        [self.orderBtn setTitle:[NSString stringWithFormat:@"%@",categoryModel.cName]
                          forState:UIControlStateNormal];
    }else{
        [self.orderBtn setTitle:@"全部分类" forState:UIControlStateNormal];
    }
    self.cid = categoryModel.cid;
    self.currentPageAll = 1;
    [self.itemListAll removeAllObjects];
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPageAll Cid:self.cid Type:self.type Order:self.order];
}
#pragma mark - YouHuiOrderViewControllerDelegate
-(void)youHuiOrderViewControllerDidSelected:(NSUInteger)index{
    //@[@"默认排序",@"人气优先",@"收藏数量",@"结束时间"];
    switch (index) {
        case 0: {
            self.order = @"";
            [self.typeBtn setTitle:@"默认排序" forState:UIControlStateNormal];
        }
            break;
        case 1:{
            self.order = @"hot";
            [self.typeBtn setTitle:@"人气优先" forState:UIControlStateNormal];
        }
            break;
        case 2:{
            self.order = @"collect";
            [self.typeBtn setTitle:@"收藏数量" forState:UIControlStateNormal];
        }
            break;
        case 3:{
            self.order = @"latest";
            [self.typeBtn setTitle:@"结束时间" forState:UIControlStateNormal];
        }
        default:
            break;
    }
    
    //@[@"",@"人气",@"收藏",@"结束时间"];
    self.currentPageAll = 0;
    [self.itemListAll removeAllObjects];
    self.currentPageAll = 1;
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPageAll Cid:self.cid Type:self.type Order:self.order];
}

- (IBAction)btnOrderAction:(UIButton *)sender {
    YouHuiOrderViewController *vc= [[YouHuiOrderViewController alloc]init];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
    [vc release];
    
    self.isOrder = YES;
}

- (IBAction)btnCategoryAction:(UIButton *)sender {
    YouhuiCategoryViewController *cateVC = [[YouhuiCategoryViewController alloc] initWithCategoryModel:self.filterCategory];
    cateVC.delegate = self;
    cateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cateVC animated:YES];
    cateVC.hidesBottomBarWhenPushed = NO;
    [cateVC release];
    
    self.isOrder = YES;
}
@end
