//
//  SaveAddBankCardInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"
//#import <Foundation/Foundation.h>

//@interface SaveAddBankCardInterface : NSObject
@interface SaveAddBankCardInterface : BaseInterface<BaseInterfaceDelegate>

-(void)SaveAddBankCardWithDictionary:(NSDictionary *)dict;

@end
