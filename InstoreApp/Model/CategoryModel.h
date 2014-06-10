//
//  CategoryModel.h
//  InstoreApp
//  分类Model
//
//
//  Created by evil on 14-4-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic,assign) NSInteger cid;
@property (nonatomic,strong) NSString *cName;

@property (nonatomic,strong) NSString *subhead;
@property (nonatomic,strong) NSString *imageUrl;


-(id)initWithJsonMap:(NSDictionary *)jsonMap;
@end
