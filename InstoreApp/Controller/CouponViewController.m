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

@interface CouponViewController () <UITableViewDataSource, UITableViewDelegate, CouponViewInterfaceDelegate>

@property (nonatomic, retain) NSMutableDictionary *itemListDict;//关注的商户的优惠集合
@property (nonatomic, retain) NSDictionary *otherGroupDict;//其他组内容集合

@property (nonatomic, assign) NSInteger listTotalCount;//关注的商户的优惠总数
@property (nonatomic, retain) NSArray *otherGroupKeysOrder;//其他组的顺序，记录了所有key的名字
@property (nonatomic, assign) NSInteger currentPage;//当前页
@property (nonatomic, assign) NSInteger focusCount;//用户收藏的优惠数量

@property (nonatomic, retain) CouponViewInterface *couponViewInterface;

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
    
    self.couponViewInterface = [[[CouponViewInterface alloc] init] autorelease];
    self.couponViewInterface.delegate = self;
    [self.couponViewInterface getCouponViewListByPage:self.currentPage amount:20];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.mtableView = nil;
    
    [super dealloc];
}

#pragma mark - UITableViewDataSource<NSObject>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count] / 2)+1;
    
    if (self.listTotalCount == [[self.itemListDict objectForKey:@"itemlist"] count]) {
        for (NSString *key in self.otherGroupKeysOrder) {
            numberOfRows += ceil((float)[[[self.otherGroupDict objectForKey:key] objectForKey:@"itemlist"] count] / 2);
            numberOfRows += 1;//每个group有个标题view
        }
    }
    
    return numberOfRows;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    if (indexPath.row == 0) {
        NSLog(@"----======%d===--45",indexPath.row);
        return 45;
    }else{
        if (indexPath.row <= (ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count]/2))) {
            NSLog(@"----======%d===--236",indexPath.row);
            return 236;
        }else{
            NSInteger rowNumTmp = ceil((float)[[self.itemListDict objectForKey:@"itemlist"] count]/2)+1;
            for (NSString *key in self.otherGroupKeysOrder) {
                if (indexPath.row == rowNumTmp) {
                    NSLog(@"----======%d===--45",indexPath.row);
                    return 45;
                }else if (indexPath.row < rowNumTmp) {
                    break;
                }
                rowNumTmp += (ceil((float)[[[self.otherGroupDict objectForKey:key] objectForKey:@"itemlist"] count]/2)+1);
            }
            NSLog(@"----======%d===--236",indexPath.row);
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

@end
