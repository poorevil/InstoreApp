//
//  MessageINterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol MessageInterfaceDelegate <NSObject>

-(void)getMessageInterfaceListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;
-(void)getMessageInterfaceListDidFailed:(NSString *)errorMsg;

@end

@interface MessageInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<MessageInterfaceDelegate>delegate;
-(void)getMessageInterfaceListByPage:(NSInteger)page amount:(NSInteger)amount;

@end
