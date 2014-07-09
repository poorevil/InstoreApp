//
//  FocusStoreInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@interface FocusStoreInterface : BaseInterface<BaseInterfaceDelegate>

-(void)focusStoreWithID:(NSInteger)storeID WithMethod:(NSString *)method;

@end
