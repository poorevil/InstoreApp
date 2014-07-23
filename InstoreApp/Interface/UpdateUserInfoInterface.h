//
//  UpdateUserInfoInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@interface UpdateUserInfoInterface : BaseInterface

-(void)updateUserInfoWithName:(NSString *)name Gender:(NSInteger)gender NickName:(NSString *)nickName Email:(NSString *)email Birthday:(NSString *)birthday;

@end
