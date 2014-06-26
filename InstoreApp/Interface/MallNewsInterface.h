//
//  MallNewsInterface.h
//  InstoreApp
//  商场活动
//  Created by evil on 14-6-26.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol MallNewsInterfaceDelegate <NSObject>

-(void)getMallNewsDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;

-(void)getmallNewsDidFailed:(NSString *)errorMsg;

@end

@interface MallNewsInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic, assign) id<MallNewsInterfaceDelegate> delegate;

-(void)getMallNewsByPage:(NSInteger)page amount:(NSInteger)amount;

@end
