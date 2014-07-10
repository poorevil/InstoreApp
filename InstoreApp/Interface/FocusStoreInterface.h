//
//  FocusStoreInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

//关注或者取消关注某个商户

#import "BaseInterface.h"

@interface FocusStoreInterface : BaseInterface<BaseInterfaceDelegate>

-(void)focusStoreWithID:(NSInteger)storeID WithMethod:(NSString *)method;

@end
