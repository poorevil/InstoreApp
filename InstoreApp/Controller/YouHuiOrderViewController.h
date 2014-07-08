//
//  YouHuiOrderViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YouHuiOrderViewControllerDelegate <NSObject>

-(void)youHuiOrderViewControllerDidSelected:(NSString *)order;

@end

@interface YouHuiOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) NSArray *list;
@property (retain, nonatomic) NSArray *result;
@property (assign, nonatomic) id<YouHuiOrderViewControllerDelegate>delegate;

@end
