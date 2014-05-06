//
//  StoreFocusInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol StoreFocusInterfaceDelegate <NSObject>

-(void)setStoreFocusDidFinished;
-(void)setStoreFocusDidFailed:(NSString *)errorMessage;

@end

@interface StoreFocusInterface : BaseInterface <BaseInterfaceDelegate>
@property (nonatomic,assign) id<StoreFocusInterfaceDelegate> delegate;

-(void)setStoreFocusByShopIds:(NSArray *)shopIds isUp:(BOOL)isUp;

@end
