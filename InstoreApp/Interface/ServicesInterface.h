//
//  ServicesInterface.h
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol ServicesInterfaceDelegate <NSObject>

-(void)getServicesListDidFinished:(NSArray *)resultList totalCount:(NSInteger)totalCount;
-(void)getServicesListDidFailed:(NSString *)errorMessage;

@end

@interface ServicesInterface : BaseInterface <BaseInterfaceDelegate>
@property (nonatomic,assign) id<ServicesInterfaceDelegate> delegate;

-(void)getServicesList;

@end
