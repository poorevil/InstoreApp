//
//  HuiGuangModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HuiGuangModel : NSObject

@property (assign, nonatomic) NSInteger storeOrSaler;//1 商店  2 店员
@property (assign, nonatomic) NSString *imageIconURL;
@property (retain, nonatomic) NSString *imageURL;
@property (retain, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger commentCount; //评论数量
@property (retain, nonatomic) NSArray *commentList;   //评论列表

@end
