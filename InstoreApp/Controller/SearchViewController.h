//
//  SearchViewController.h
//  InstoreApp
//
//  Created by han chao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *mtableView;

- (IBAction)btnHotSearchAction:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnHotWord1;
@property (retain, nonatomic) IBOutlet UIButton *btnHotWord2;
@property (retain, nonatomic) IBOutlet UIButton *btnHotWord3;


@end
