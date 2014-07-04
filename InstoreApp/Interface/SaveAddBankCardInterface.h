//
//  SaveAddBankCardInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol SaveAddBankCardInterfaceDelegate <NSObject>

-(void)getReceivedFromPoatAddBankCard:(NSString *)result;

@end
@interface SaveAddBankCardInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<SaveAddBankCardInterfaceDelegate>delegate;
-(void)SaveAddBankCardWithDictionary:(NSDictionary *)dict;

@end
