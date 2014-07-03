//
//  AddBankCardModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-3.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddBankCardModel : NSObject

@property (assign, nonatomic) NSInteger bankId;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *logo;
@property (assign, nonatomic) BOOL choosed;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
