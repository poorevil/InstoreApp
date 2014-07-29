//
//  MallNewsModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallNewsModel : NSObject

@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *summary;
@property (assign, nonatomic) NSInteger cid;
@property (retain, nonatomic) NSString *image;
@property (retain, nonatomic) NSDate *date;
@property (retain, nonatomic) NSString *url;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
