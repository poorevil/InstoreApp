//
//  FocusStoreInterface.m
//  InstoreApp
//
//  Created by Mac on 14-7-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "FocusStoreInterface.h"
#import "FocusStoreModel.h"

@implementation FocusStoreInterface

-(void)focusStoreWithID:(NSInteger)storeID WithMethod:(NSString *)method{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/store/focus"
                         ,BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"id":[NSString stringWithFormat:@"%d",storeID]};
    self.requestMethod = method;
//    self.baseDelegate = self;
    [self connect];
}

//-(void)parseResult:(ASIHTTPRequest *)request{
//    
//}
//-(void)requestIsFailed:(NSError *)error{
//    
//}

@end
