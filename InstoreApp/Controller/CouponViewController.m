//
//  CouponViewController.m
//  InstoreApp
//
//  Created by hanchao on 14-6-12.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CouponViewController.h"
#import "CouponviewInterface.h"
#import "CouponView_titleCell.h"
#import "CouponView_focusedCell.h"
#import "YouhuiCategoryViewController.h"
#import "YouHuiPromotionTypeViewController.h"
#import "YouHuiOrderViewController.h"
#import "CategoryModel.h"
#import "CouponSearchOrderInterface.h"


@interface CouponViewController () <UITableViewDataSource, UITableViewDelegate,
CouponViewInterfaceDelegate, YouhuiCategoryViewControllerDelegate,YouHuiPromotionTypeViewControllerDelegate,YouHuiOrderViewControllerDelegate,CouponSearchOrderInterfaceDelegate>

@property (nonatomic, retain) NSMutableDictionary *itemListDict;//关注的商户的优惠集合
@property (nonatomic, retain) NSDictionary *otherGroupDict;//其他组内容集合

@property (nonatomic, assign) NSInteger listTotalCount;//关注的商户的优惠总数
@property (nonatomic, retain) NSArray *otherGroupKeysOrder;//其他组的顺序，记录了所有key的名字
@property (nonatomic, assign) NSInteger currentPage;//当前页
@property (nonatomic, assign) NSInteger focusCount;//用户收藏的优惠数量

@property (nonatomic, retain) CouponViewInterface *couponViewInterface;

@property (nonatomic,strong) CategoryModel *filterCategory;//分类筛选条件

@property (retain, nonatomic) NSMutableArray *itemList;
@property (retain, nonatomic) CouponSearchOrderInterface *couponSearchOrderInterface;
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
    self.currentPage = 1;
    
    self.title = @"优惠";
    [self initToolBar];
    
    self.itemList = [NSMutableArray array];
    
    self.couponViewInterface = [[[CouponViewInterface alloc] init] autorelease];
    self.couponViewInterface.delegate = self;
    [self.couponViewInterface getCouponViewListByPage:self.currentPage amount:20];
    
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
    self.mtableView = nil;
    self.couponSearchOrderInterface = nil;
    self.couponViewInterface = nil;
    self.itemListDict = nil;
    self.otherGroupDict = nil;
    self.otherGroupKeysOrder = nil;
    self.filterCategory = nil;
    
    [super dealloc];
}

#pragma mark - private method
-(void)initToolBar
{
    [self.cateBtn setImageEdgeInsets:UIEdgeInsetsMake(0,self.cateBtn.frame.size.width-self.cateBtn.imageView.frame.size.width,0,0)];
    [self.cateBtn addTarget:self action:@selector(btnYouHuiPromotionTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.typeBtn setImageEdgeInsets:UIEdgeInsetsMake(0,self.typeBtn.frame.size.width-self.typeBtn.imageView.frame.size.width,0,0)];
    [self.typeBtn addTarget:self action:@selector(categoryBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.orderBtn setImageEdgeInsets:UIEdgeInsetsMake(0,self.orderBtn.frame.size.width-self.orderBtn.imageView.frame.size.width,0,0)];
    [self.orderBtn addTarget:self action:@selector(btnYouHuiOrderAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.favorBtn setImageEdgeInsets:UIEdgeInsetsMake(0,
//                                                       0,
//                                                       0,
//                                                       self.favorBtn.frame.size.width-self.favorBtn.imageView.frame.size.width)];
}

-(void)categoryBtnAction:(id)sender
{
    YouhuiCategoryViewController *cateVC = [[YouhuiCategoryViewController alloc] initWithCategoryModel:self.filterCategory];
    cateVC.delegate = self;
    cateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cateVC animated:YES];
    cateVC.hidesBottomBarWhenPushed = NO;
    [cateVC release];
    
    self.isOrder = YES;
}
-(void)btnYouHuiPromotionTypeAction:(UIButton *)sender{
    YouHuiPromotionTypeViewController *vc = [[YouHuiPromotionTypeViewController alloc]init];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
    [vc release];
    
    self.isOrder = YES;
}
-(void)btnYouHuiOrderAction:(UIButton *)sender{
    YouHuiOrderViewController *vc= [[YouHuiOrderViewController alloc]init];
    vc.delegate = self;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
    [vc release];
    
    self.isOrder = YES;
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOrder) {
        return ceil(self.itemList.count / 2);
    }
    //************************************
    if (!self.otherGroupKeysOrder) {
        return 0;
    }
    
    //ceil:返回大于或者等于指定表达式的最小整数
    NSInteger numberOfRows = ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count] / 2)+1;
    
    if (self.listTotalCount == [[self.itemListDict objectForKey:@"itemlist"] count]) {
        for (NSString *key in self.otherGroupKeysOrder) {
            numberOfRows += ceil((float)[[[self.otherGroupDict objectForKey:key] objectForKey:@"itemlist"] count] / 2);
            numberOfRows += 1;//每个group有个标题view
        }
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isOrder) {
        static NSString *CellIndentifier = @"Cell";
        CouponView_focusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.cm1 = [self.itemList objectAtIndex:indexPath.row * 2];
        cell.cm2 = [self.itemList objectAtIndex:(indexPath.row * 2 + 1)];
        return cell;
    }
    
    //*************************************
    NSString *cellIdentifier = [self getCellIdentifier:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        if ([cellIdentifier isEqualToString:@"title"]) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_titleCell"
                                                 owner:self
                                                options:nil] objectAtIndex:0];
            
            
        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponView_focusedCell"
                                                  owner:self
                                                options:nil] objectAtIndex:0];
        }
    }
    
    //对应行号和list的位置的偏移量
    NSInteger indexOffsetOfList = [[[self getDictByRowNum:indexPath.row] objectForKey:@"offset"] integerValue];
    NSDictionary *dict = [[self getDictByRowNum:indexPath.row] objectForKey:@"dict"];
    if ([cellIdentifier isEqualToString:@"title"]) {
        CouponView_titleCell *c = (CouponView_titleCell*)cell;
        c.titleLabel.text = [dict objectForKey:@"categoryTitle"];
    }else{
        CouponView_focusedCell *c = (CouponView_focusedCell*)cell;
        if ((indexPath.row-indexOffsetOfList)*2 < [[dict objectForKey:@"itemlist"] count]) {
            c.cm1 = [[dict objectForKey:@"itemlist"] objectAtIndex:(indexPath.row-indexOffsetOfList)*2];
        }else{
            c.cm1 = nil;
        }
        
        if ((indexPath.row-indexOffsetOfList)*2+1 < [[dict objectForKey:@"itemlist"] count]) {
            c.cm2 = [[dict objectForKey:@"itemlist"] objectAtIndex:(indexPath.row-indexOffsetOfList)*2+1];
        }else{
            c.cm2 = nil;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isOrder) {
        return 236;
    }
    //******************************************
    if (indexPath.row == 0) {
        return 45;
    }else{
        if (indexPath.row <= (ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count]/2))) {
            return 236;
        }else{
            NSInteger rowNumTmp = ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count]/2)+1;
            for (NSString *key in self.otherGroupKeysOrder) {
                if (indexPath.row == rowNumTmp) {
                    return 45;
                }else if (indexPath.row < rowNumTmp) {
                    break;
                }
                rowNumTmp += (ceil((float)[[[self.otherGroupDict objectForKey:key] objectForKey:@"itemlist"] count]/2)+1);
            }
            return 236;
        }
    }
}

#pragma mark - CouponViewInterfaceDelegate <NSObject>
- (void)getCouponViewListDidFinished:(NSDictionary *)resultDict
                          focusCount:(NSInteger)focusCount
                          totalCount:(NSInteger)totalCount
                         currentPage:(NSInteger)currentPage
{
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
    
}

- (void)getCouponViewListDidFailed:(NSString *)errorMsg
{
    NSLog(@"%@",errorMsg);
}

#pragma mark - CouponSearchOrderInterfaceDelegate
-(void)couponSearchOrderDidFinished:(NSArray*)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage{
    [self.itemList addObjectsFromArray:result];
//    self.totalAmount = totalAmount;
    self.currentPage = currentPage;
    self.currentPage++;
    
    [self.mtableView reloadData];
    [self.mtableView scrollRectToVisible:CGRectMake(0, 0, 320, 1) animated:YES];
}
-(void)couponSearchOrderDidFailed:(NSString*)errorMessage{
//    NSLog(@"%s:%@",__FUNCTION__,errorMessage);
}

#pragma mark - YouhuiCategoryViewControllerDelegate
-(void)categoryDidSelected:(CategoryModel *)categoryModel
{
    self.filterCategory = categoryModel;
    if (self.filterCategory) {
        [self.typeBtn setTitle:[NSString stringWithFormat:@"%@ ",categoryModel.cName]
                          forState:UIControlStateNormal];
    }else{
        [self.typeBtn setTitle:@"分类 " forState:UIControlStateNormal];
    }
    self.cid = categoryModel.cid;
    self.currentPage = 0;
    [self.itemList removeAllObjects];
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPage Cid:self.cid Type:self.type Order:self.order];
//    [self refreshTable];
}
#pragma mark - YouHuiPromotionTypeViewControllerDelegate
-(void)youHuiPromotionTypeViewControllerDidSelected:(NSString *)promotionType{
//    NSLog(@"%s:%@",__FUNCTION__,promotionType);
    [self.cateBtn setTitle:promotionType forState:UIControlStateNormal];
    
    //<1, '优惠活动'>, <2, '优惠券'>, <3, '团购'>
    if ([promotionType isEqualToString:@"优惠活动"]) {
        self.type = 1;
    }else if ([promotionType isEqualToString:@"优惠券"]){
        self.type = 2;
    }else if([promotionType isEqualToString:@"优惠活动"]){
        self.type = 3;
    }else{
        self.type = 0;
    }
    self.currentPage = 0;
    [self.itemList removeAllObjects];
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPage Cid:self.cid Type:self.type Order:self.order];
}
#pragma mark - YouHuiOrderViewControllerDelegate
-(void)youHuiOrderViewControllerDidSelected:(NSString *)order{
//    NSLog(@"%s:%@",__FUNCTION__,order);
    if ([order isEqualToString:@"人气"]) {
        self.order = @"hot";
    }else if([order isEqualToString:@"收藏"]){
        self.order = @"collect";
    }else if ([order isEqualToString:@"结束时间"]){
        self.order = @"latest";
    }else{
        self.order = @"";
        order = @"默认";
    }
    [self.orderBtn setTitle:order forState:UIControlStateNormal];
    
    //@[@"",@"人气",@"收藏",@"结束时间"];
    self.currentPage = 0;
    [self.itemList removeAllObjects];
    [self.couponSearchOrderInterface searchByAmount:20 Page:self.currentPage Cid:self.cid Type:self.type Order:self.order];
}

//根据行号获取对应的组的dict集合
-(NSDictionary *)getDictByRowNum:(NSInteger)rowNum
{
    if (rowNum <= ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count]/2)) {
        return @{@"dict":self.itemListDict,
                 @"offset":[NSNumber numberWithInt:1]};
    }else{
        NSInteger beginRowNum = ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count]/2)+1;
        NSInteger endRowNum = beginRowNum;
        for (NSString *key in self.otherGroupKeysOrder) {
            endRowNum = beginRowNum + ceil((float)[[[self.otherGroupDict objectForKey:key] objectForKey:@"itemlist"] count]/2);
            if (rowNum >= beginRowNum && rowNum <= endRowNum) {
                return @{@"dict":[self.otherGroupDict objectForKey:key],
                         @"offset":[NSNumber numberWithInt:beginRowNum +1]};
            }
            beginRowNum = endRowNum + 1;
        }
    }
    
    return nil;
}

-(NSString *)getCellIdentifier:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return @"title";
    }else{
        if (indexPath.row <= (ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count]/2))) {
            return @"focused";
        }else{
            NSInteger rowNumTmp = ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count]/2)+1;
            for (NSString *key in self.otherGroupKeysOrder) {
                if (indexPath.row == rowNumTmp) {
                    return @"title";
                }else if (indexPath.row < rowNumTmp) {
                    break;
                }
                rowNumTmp += (ceil((float)[[[self.otherGroupDict objectForKey:key] objectForKey:@"itemlist"] count]/2)+1);
            }
            return @"focused";
        }
    }
}
@end
