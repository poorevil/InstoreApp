//
//  AddBandCardInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol AddBankCardDelegate <NSObject>

-(void)getAddBankCardDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;
-(void)getAddBankCardDidFailed:(NSString *)errorMsg;

@end

@interface AddBandCardInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<AddBankCardDelegate>delegate;
-(void)getAddBankCardByPage:(NSInteger)page amount:(NSInteger)amount;

@end
