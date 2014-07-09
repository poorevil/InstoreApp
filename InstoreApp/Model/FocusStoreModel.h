//
//  FocusStoreModel.h
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusStoreModel : NSObject

@property (assign, nonatomic) NSInteger storeID;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *logo;
@property (assign, nonatomic) NSInteger followerCount;
@property (assign, nonatomic) BOOL isFocus;

-(id)initWithJsonMap:(NSDictionary*)jsonMap;

@end
