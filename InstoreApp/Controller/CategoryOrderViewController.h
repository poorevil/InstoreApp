//
//  CategoryOrderViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryOrderViewControllerHaveSelectedCategoryDelegate <NSObject>

-(void)categoryOrderViewControllerHaveSelectedCategory:(NSString *)result;

@end

@interface CategoryOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSArray *list;
@property (retain, nonatomic) NSString *nowSelectedString;
@property (assign, nonatomic) id<CategoryOrderViewControllerHaveSelectedCategoryDelegate>delegate;
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@end
