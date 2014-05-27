//
//  StoreFocusInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-6.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "StoreFocusInterface.h"
@interface StoreFocusInterface()
@property (nonatomic,assign) BOOL isUp;
@end

@implementation StoreFocusInterface

-(void)setStoreFocusByShopIds:(NSArray *)shopIds isUp:(BOOL)isUp{
    self.isUp = isUp;
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/shop_focus/%@",BASE_INTERFACE_DOMAIN, MALL_CODE,isUp?@"up":@"down"];
    self.postParams = @{@"shopid":[shopIds componentsJoinedByString:@","]};
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
-(void)parseResult:(ASIHTTPRequest *)request{
    if ([self.delegate respondsToSelector:@selector(setStoreFocusDidFinished)]) {
        [self.delegate setStoreFocusDidFinished];
    }
    
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(setStoreFocusDidFailed:)]) {
        [self.delegate setStoreFocusDidFailed:[NSString stringWithFormat:@"%@失败！(%@)",self.isUp?@"关注":@"取消关注",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
