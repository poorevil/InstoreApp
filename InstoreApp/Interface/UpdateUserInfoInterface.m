//
//  UpdateUserInfoInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-23.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "UpdateUserInfoInterface.h"

@implementation UpdateUserInfoInterface

//https://github.com/joyx-inc/vmall-app-ios/wiki/User-Info-Update
-(void)updateUserInfoWithName:(NSString *)name Gender:(NSInteger)gender NickName:(NSString *)nickName Email:(NSString *)email Birthday:(NSString *)birthday{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/myinfo"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (name) {
        [dictionary setObject:name forKey:@"name"];
    }
    [dictionary setObject:[NSString stringWithFormat:@"%d",gender] forKey:@"gender"];
    [dictionary setObject:nickName forKey:@"nickName"];
    if (email) {
        [dictionary setObject:email forKey:@"email"];
    }
    if (birthday) {
        [dictionary setObject:birthday forKey:@"birthday"];
    }
    
    
//    NSDictionary *dict = @{@"name":name ,
//                           @"gender":[NSString stringWithFormat:@"%d",gender],
//                           @"nickName":nickName,
//                           @"email":email,
//                           @"birthday":birthday};
    self.args = dictionary;
    self.requestMethod = @"POST";
//    self.postParams = dictionary;
    [self connect];
}

@end
