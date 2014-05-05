//
//  CategoryInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol CategoryInterfaceDelegate <NSObject>

-(void)getCategoryListDidFinished:(NSArray *)categoryList totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
-(void)getCategoryListDidFailed:(NSString *)errorMessage;

@end

@interface CategoryInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<CategoryInterfaceDelegate> delegate;

-(void)getCategoryListByPage:(NSInteger) page amount:(NSInteger) amount;
@end
