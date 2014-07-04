//
//  DeleteBankCardInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-4.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@interface DeleteBankCardInterface : BaseInterface<BaseInterfaceDelegate>

-(void)deleteBankCardWithBankId:(NSInteger)bankId;

@end
