//
//  HuiGuangModel.m
//  InstoreApp
//
//  Created by Mac on 14-7-22.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "HuiGuangModel.h"

@implementation HuiGuangModel

-(void)dealloc{
    self.imageURL = nil;
    self.title = nil;
    self.commentList = nil;
    self.imageIconURL = nil;
    
    [super dealloc];
}
@end
