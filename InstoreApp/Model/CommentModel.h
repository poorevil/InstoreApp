//
//  CommentModel.h
//  InstoreApp
//
//  Created by hanchao on 14-5-13.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSDate *createTime;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
