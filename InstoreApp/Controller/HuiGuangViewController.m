//
//  HuiGuangViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "HuiGuangViewController.h"
#import "HuiGuangModel.h"
#import "HuiGuangCell.h"

@interface HuiGuangViewController ()

@end

@implementation HuiGuangViewController

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
    
    self.title = @"惠逛模式(Demo)";
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.rightBarButtonItem = nil;
    
    
    NSMutableArray *list = [NSMutableArray array];
    
    HuiGuangModel *model1 = [[HuiGuangModel alloc]init];
    model1.imageIconURL = @"http://www.wise-mall.com/img/11_0_742.png";
    model1.imageURL = @"http://www.wise-mall.com/img/11_0_778.jpg";
    model1.title = @"原价499，现价99，仅限一天。";
    NSDictionary *dict1 = @{@"name":@"蜡笔",@"comment":@"很不错。"};
    model1.commentList = @[dict1];
    model1.commentCount = 1;
    [list addObject:model1];
    [model1 release];
    
    HuiGuangModel *model2 = [[HuiGuangModel alloc]init];
    model2.imageIconURL = @"http://www.wise-mall.com/img/11_0_742.png";
    model2.imageURL = @"http://www.wise-mall.com/img/11_0_775.jpg";
    model2.title = @"全出满100送100.";
    model2.commentCount = 0;
    [list addObject:model2];
    [model2 release];
    
    HuiGuangModel *model3 = [[HuiGuangModel alloc]init];
    model3.imageIconURL = @"http://www.wise-mall.com/img/11_0_738.png";
    model3.imageURL = @"http://www.wise-mall.com/img/11_0_777.jpg";
    model3.title = @"秒杀，女款风衣折后仅199，速来抢购吧";
    NSDictionary *dict3 = @{@"name": @"小悦",@"comment":@"非常喜欢。非常喜欢。非常喜欢。非常喜欢。非常喜欢。非常喜欢。"};
    model3.commentList = @[dict3];
    model1.commentCount = 1;
    model3.storeOrSaler = 1;
    [list addObject:model3];
    [model3 release];
    
    HuiGuangModel *model4 = [[HuiGuangModel alloc]init];
    model4.imageIconURL = @"http://www.wise-mall.com/img/11_0_742.png";
    model4.imageURL = @"http://www.wise-mall.com/img/11_0_776.jpg";
    model4.title = @"全场买一送一。";
    NSDictionary *dict4 = @{@"name":@"小新",@"comment":@"非常喜欢。"};
    model4.commentList = @[dict4];
    model4.commentCount = 1;
    [list addObject:model4];
    [model4 release];
    
    self.itemList = list;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HuiGuangModel *model = [self.itemList objectAtIndex:indexPath.row];
    CGSize sizeMax = CGSizeMake(140, 50);
    NSString *string = model.title;
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:sizeMax lineBreakMode:NSLineBreakByWordWrapping];
    if (size.height > 30) {
        if (model.commentCount > 0) {
            return 131;
        }
    }
    return 114;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    HuiGuangCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HuiGuangCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.huiGuangModel = [self.itemList objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    [_labPosition release];
    [super dealloc];
}
- (IBAction)btnMapAction:(UIButton *)sender {
}
@end
