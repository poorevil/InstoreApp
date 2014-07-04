//
//  BankCardDetailInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-4.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol BankCardDetailInterfaceDelegate <NSObject>

-(void)getBankCardDetailDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;
-(void)getBankCardDetailDidFailed:(NSString *)errorMsg;

@end

@interface BankCardDetailInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<BankCardDetailInterfaceDelegate>delegate;
-(void)getBankCardDetailByPage:(NSInteger)page amount:(NSInteger)amount andBankId:(NSInteger)bandId;

@end
