//
//  RuntimeModel.h
//  InstoreApp
//
//  初始化接口model
//
//  Created by evil on 14-4-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeModel : NSObject

@property (nonatomic,strong) NSString *appName;
@property (nonatomic,strong) NSString *secretKey;
@property (nonatomic,strong) NSString *mallCode;
@property (nonatomic,strong) NSString *mallLogo;
@property (nonatomic,strong) NSString *mallMapId;
@property (nonatomic,assign) NSInteger mallId;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,assign) BOOL isNewUser;
@property (nonatomic,strong) NSString *mallName;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;


@end
