//
//  MallNewsModel.h
//  InstoreApp
//  商场活动
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MallNewsModel : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, retain) NSString *summary;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *imageUrl;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
