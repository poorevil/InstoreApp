//
//  MyVIPCardViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-16.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MyVIPCardViewController.h"
#import "QrCodeViewCell.h"

@interface MyVIPCardViewController ()

@end

@implementation MyVIPCardViewController

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
    
    self.hidesBottomBarWhenPushed = YES;
    self.title = @"我的会员卡";
    [self initHeaderView];
    
    self.list = @[@"我的积分",@"积分兑换",@"会员指南"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.VIPCardNumberImage) {
        return 2;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.VIPCardNumberImage) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 80;
        }
    }
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.VIPCardNumberImage) {
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return 3;
                break;
            default:
                return 0;
                break;
        }
    }else{
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.VIPCardNumberImage) {
        switch (indexPath.section) {
            case 0:{
                static NSString *CellIdentifier = @"QrCodeViewCell";
                QrCodeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[[NSBundle mainBundle] loadNibNamed:@"QrCodeViewCell" owner:self options:nil] lastObject];
                }
                cell.imageQrCode.image = [UIImage imageNamed:@"tempCode.png"];
                cell.labQRCode.text = @"546464776547684768";
                return cell;
            }
                break;
            }
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:1];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:244/255.0 green:155/255.0 blue:27/255.0 alpha:1];
    }
    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    if (indexPath.row == 0 ) {
        if (self.VIPCardNumberImage) {
            cell.detailTextLabel.text = @"9999积分";
        }else{
            cell.detailTextLabel.text = @"未开通会员卡";
        }
    }
    return cell;
}

-(void)dealloc{
    self.list = nil;
    self.VIPCardNumberImage = nil;
    
    [_myTableView release];
    [super dealloc];
}

-(void)initHeaderView{
    UIView *view = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 205)]autorelease];
    view.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 300, 195)];
    if (self.VIPCardNumberImage) {
        imageView.image = self.VIPCardNumberImage;
    }else{
        imageView.image = [UIImage imageNamed:@"my_card_NO_bangding.png"];
    }
    [view addSubview:imageView];
    [imageView release];
    
    if (!self.VIPCardNumberImage) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 300, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"您尚未绑定商场会员卡";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        [view addSubview:label];
        [label release];
        
        UIButton *btnAddSotreVIPCard = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAddSotreVIPCard.frame = CGRectMake(100, 110, 120, 30);
        [btnAddSotreVIPCard setImage:[UIImage imageNamed:@"my_card_btnAddCard.png"] forState:UIControlStateNormal];
        [btnAddSotreVIPCard addTarget:self action:@selector(btnAddSotreVIPCardAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btnAddSotreVIPCard];
    }

    self.myTableView.tableHeaderView = view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.VIPCardNumberImage) {
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                    //我的积分
                    
                    break;
                case 1:{
                    //积分兑换
                    
                }
                    break;
                case 2:{
                    //会员指南
                    
                }
                    break;
                default:
                    break;
            }
        }
    }
}
-(void)btnAddSotreVIPCardAction:(UIButton *)sender{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
