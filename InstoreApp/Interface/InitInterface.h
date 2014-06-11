//
//  InitInterface.h
//  InstoreApp
//
//  Created by evil on 14-4-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol InitInterfaceDelegate <NSObject>

-(void)getInitParamDidFinished;
-(void)getInitParamDidFailed:(NSString *)errorMsg;

@end

@interface InitInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic, assign) id<InitInterfaceDelegate> delegate;
-(void)getInitParam;

@end
