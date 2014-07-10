//
//  MyFocusYouHuiInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-10.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol MyFocusYouHuiInterfaceDelegate <NSObject>

-(void)getMyFocusYouHuiListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage;
-(void)getMyFocusYouHuiListDidFailed:(NSString *)errorMsg;

@end

@interface MyFocusYouHuiInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<MyFocusYouHuiInterfaceDelegate>delegate;
-(void)getMyFocusYouHuiListWithAmount:(NSInteger)amount Page:(NSInteger)page;

@end
