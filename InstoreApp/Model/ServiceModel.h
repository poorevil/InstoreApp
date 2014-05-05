//
//  ServiceModel.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject
//{
//    "name":"对象名称",
//    "itemType":"对象类型",      //  #1:内置功能; 0: 网页
//    "itemId":"对象id",
//    "picUrl":"图片地址"
//    "link":"链接地址"           // itemType为0的时候才有值
//}

@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger itemType;
@property (nonatomic,assign) NSInteger sid;
@property (nonatomic,strong) NSString *picUrl;
@property (nonatomic,strong) NSString *link;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;
@end
