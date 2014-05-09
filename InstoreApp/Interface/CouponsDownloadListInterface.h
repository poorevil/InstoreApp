//
//  CouponsDownloadListInterface.h
//  InstoreApp
//  我的优惠劵接口
//  Created by hanchao on 14-5-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol CouponsDownloadListInterfaceDelegate <NSObject>

-(void)getCouponsDownloadListDidFinished:(NSArray *)result totalAmount:(NSInteger)totalAmount currentPage:(NSInteger)currentPage;
-(void)getCouponsDownloadListFailed:(NSString *)errorMessage;

@end

@interface CouponsDownloadListInterface : BaseInterface <BaseInterfaceDelegate>

@property (nonatomic,assign) id<CouponsDownloadListInterfaceDelegate> delegate;

-(void)getCouponsDownloadList;

@end
