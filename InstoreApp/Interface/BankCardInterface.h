//
//  BankCardInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol BankCardInterfaceDelegate <NSObject>

-(void)getBankCardDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;
-(void)getBankCardDidFailed:(NSString *)errorMsg;

@end


@interface BankCardInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<BankCardInterfaceDelegate>delegate;

-(void)getBankCardByPage:(NSInteger)page amount:(NSInteger)amount;

@end
