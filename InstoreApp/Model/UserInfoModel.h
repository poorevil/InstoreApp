//
//  UserInfoModel.h
//  InstoreApp
//
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *clubCard;

-(id)initWithJsonDict:(NSDictionary *)jsonMap;

@end
