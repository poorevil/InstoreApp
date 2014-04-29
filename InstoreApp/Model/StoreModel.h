//
//  StoreModel.h
//  InstoreApp
//
//  Created by evil on 14-4-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject

@property (nonatomic,strong) NSString *sid;
@property (nonatomic,strong) NSString *logoUrl;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,strong) NSString *title;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
