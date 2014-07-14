//
//  LunBoImageInterface.h
//  InstoreApp
//
//  Created by Mac on 14-7-14.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "BaseInterface.h"

@protocol LunBoImageInterfaceDelegate <NSObject>

-(void)getLunBoImageListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount;
-(void)getLunBoImageListDidFailed:(NSString *)errorMsg;

@end

@interface LunBoImageInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<LunBoImageInterfaceDelegate>delegate;
-(void)getLunBoImageListWithPos:(NSInteger)pos;

@end
