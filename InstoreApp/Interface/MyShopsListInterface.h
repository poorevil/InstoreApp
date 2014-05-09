//
//  MyShopsListInterface.h
//  InstoreApp
//  我关注的商家接口
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol MyShopsListInterfaceDelegate <NSObject>

-(void)getMyShopsListDidFinished:(NSArray *)shopsArray totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
-(void)getMyShopsListDidFailed:(NSString *)errorMessage;

@end

@interface MyShopsListInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<MyShopsListInterfaceDelegate> delegate;

-(void)getMyShopsList;

@end
