//
//  GlobeModel.m
//  InstoreApp
//
//  Created by evil on 14-4-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "GlobeModel.h"

#import "KeyChainTool.h"
#import "RuntimeModel.h"

@implementation GlobeModel

+ (GlobeModel *)sharedSingleton
{
    static GlobeModel *sharedSingleton=nil;
    
    @synchronized(self)
    {
        if (!sharedSingleton){
            sharedSingleton = [[GlobeModel alloc] init];
            sharedSingleton.runtimeModel = [[[RuntimeModel alloc] init] autorelease];
            [sharedSingleton initUUIDIfNeeded];
        }
        
//        if (sharedSingleton.appKey == NULL || sharedSingleton.appSecret == NULL
//            || sharedSingleton.taokeName == NULL) {
//            //获取运行时参数
//            sharedSingleton.interface = [[[RuntimeParamInterface alloc] init] autorelease];
//            [sharedSingleton.interface getParam];
//        }
        
        return sharedSingleton;
    }
}

-(void)initUUIDIfNeeded
{
    if (!(self.userId = [KeyChainTool getValueByKey:KEYCHAIN_USERID_KEYNAME])) {
        self.userId = [KeyChainTool GUIDString];
        [KeyChainTool setValue:self.userId forKey:KEYCHAIN_USERID_KEYNAME];
    }
}

-(void)dealloc
{
    self.runtimeModel = nil;
    self.userId = nil;
    
    [super dealloc];
}
@end

