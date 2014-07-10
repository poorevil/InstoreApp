//
//  FocusInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-7.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

//@protocol FocusInterfaceDelefate <NSObject>
//
//-(void)getResultFromFocusToServer:(NSString *)result;
//
//@end

@interface FocusInterface : BaseInterface/*<BaseInterfaceDelegate>*/

//@property (assign, nonatomic) id<BaseInterfaceDelegate>delegate;

-(void)sendFocusCouponID:(NSInteger)couponid;

@end
