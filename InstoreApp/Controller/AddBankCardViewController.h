//
//  AddBankCardViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"
#import "AddBandCardInterface.h"

@interface AddBankCardViewController : UIViewController<AddBankCardDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (retain, nonatomic) AddBandCardInterface *addBankCardInterface;
@property (nonatomic, retain) NSMutableArray *itemList;
@property (nonatomic, assign) NSInteger totalAmount;
@property (nonatomic, assign) NSInteger currentPage;

@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) IBOutlet UILabel *labChooeseCount;
@property (retain, nonatomic) IBOutlet UILabel *labText;
- (IBAction)btnFinishedAction:(UIButton *)sender;

@property (retain, nonatomic) NSMutableDictionary *chooeseBankCard;

@property (assign, nonatomic) int chooesedCount;

@end
