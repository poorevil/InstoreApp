//
//  CategoryListInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"
@protocol CategoryListInterfaceDelegate <NSObject>

-(void)getCategoryListDidFinished:(NSArray *)categoryList totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
-(void)getCategoryListDidFailed:(NSString *)errorMessage;

@end

@interface CategoryListInterface : BaseInterface <BaseInterfaceDelegate>
@property (nonatomic,assign) id<CategoryListInterfaceDelegate> delegate;

-(void)getCategoryListByPage:(NSInteger) page amount:(NSInteger) amount;

@end
