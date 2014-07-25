//
//  MessageModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property (assign, nonatomic) NSInteger messageID;
@property (retain, nonatomic) NSString *category;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *summary;
@property (assign, nonatomic) NSInteger readStatus;
@property (retain, nonatomic) NSDate *createDate;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
