//
//  CommentModel.m
//  InstoreApp
//
//  Created by hanchao on 14-5-13.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "CommentModel.h"
#import "NSDate+DynamicDateString.h"

@implementation CommentModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        self.author = [jsonMap objectForKey:@"author"];
        self.content = [jsonMap objectForKey:@"content"];
        self.createTime = [jsonMap objectForKey:@"createTime"]?[NSDate dateFromString:[jsonMap objectForKey:@"createTime"]]:nil;
    }
    
    return self;
}

@end
