//
//  InitInterface.m
//  InstoreApp
//
//  Created by evil on 14-4-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "InitInterface.h"
#import "RuntimeModel.h"
#import "JSONKit.h"
#import "GlobeModel.h"
#import "KeyChainTool.h"

@implementation InitInterface

-(void)getInitParam
{
    //http://www.wise-mall.com/init/bj001?userid=1234
    self.interfaceUrl = [NSString stringWithFormat:@"%@init/%@",
                         BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.args = @{@"userid":[KeyChainTool getValueByKey:KEYCHAIN_USERID_KEYNAME]};
    self.baseDelegate = self;
    
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    
//    "appName": "光耀东方",
//    "secretKey": null,
//    "mallCode": "bj001",
//    "mallLogo": "http://localhost:8000/admin/api/mall/add/",
//    "mallMapId": "123",
//    "mallId": 1,
//    "date": 1398697122064,
//    "isNewUser": 0,
//    "mallName": "光耀东方"
//    
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        @try {
            if ([jsonObj objectForKey:@"errorCode"]) {
                [self.delegate getInitParamDidFailed:[jsonObj objectForKey:@"errorMsg"]];
                return;
            }
            
            GlobeModel *globe = [GlobeModel sharedSingleton];
            globe.runtimeModel = [[RuntimeModel alloc] initWithJsonMap:jsonObj];
            
            [self.delegate getInitParamDidFinished];
        }
        @catch (NSException *exception) {
            //TODO: 缺少重试机制
            
            NSLog(@"%@",exception.reason);
            
            [self.delegate getInitParamDidFailed:exception.reason];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    NSLog(@"%@",error.description);
}

-(void)dealloc
{
    self.delegate = nil;
    
    [super dealloc];
}

@end
