//
//  YouhuiCategoryViewController.h
//  InstoreApp
//  优惠劵分类筛选页面
//  Created by evil on 14-4-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryModel;

@protocol YouhuiCategoryViewControllerDelegate <NSObject>

@required
-(void)categoryDidSelected:(CategoryModel *)categoryModel;

@end

@interface YouhuiCategoryViewController : UIViewController

@property (nonatomic,assign) id<YouhuiCategoryViewControllerDelegate> delegate;

-(id)initWithCategoryModel:(CategoryModel *)categoryModel;

@end
