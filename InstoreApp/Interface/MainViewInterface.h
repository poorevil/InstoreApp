//
//  MainViewInterface.h
//  InstoreApp
//
//  Created by evil on 14-6-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol MainViewInterfaceDelegate <NSObject>

-(void)getMainViewListDidFinished:(NSArray *)viewList
                       totalCount:(NSInteger)totalCount;
-(void)getMainViewListDidFailed:(NSString *)errorMsg;

@end

@interface MainViewInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic, assign) id<MainViewInterfaceDelegate> delegate;

-(void)getMainViewList;

@end
