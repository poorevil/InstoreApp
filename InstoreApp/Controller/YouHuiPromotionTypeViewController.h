//
//  YouHuiPromotionTypeViewController.h
//  InstoreApp
//
//  Created by Mac on 14-7-8.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YouHuiPromotionTypeViewControllerDelegate <NSObject>

-(void)youHuiPromotionTypeViewControllerDidSelected:(NSString *)promotionType;

@end

@interface YouHuiPromotionTypeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *myTableView;

@property (retain, nonatomic) NSArray *list;
@property (assign, nonatomic) id<YouHuiPromotionTypeViewControllerDelegate>delegate;

@end
