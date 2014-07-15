//
//  StoreCategoryFilterViewController.h
//  InstoreApp
//
//  Created by evil on 14-7-15.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseViewController.h"

@protocol StoreCategoryFilterViewControllerDelegate <NSObject>

@required
-(void)categorySelectDidFinished:(NSString *) category name:(NSString *)name;

@end

@interface StoreCategoryFilterViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *mtableView;
@property (nonatomic, assign) id<StoreCategoryFilterViewControllerDelegate> delegate;

@property (nonatomic, retain) NSString *category;

@end
