//
//  ServicesInterface.m
//  InstoreApp
//
//  Created by evil on 14-5-5.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ServicesInterface.h"
#import "ServiceModel.h"
#import "JSONKit.h"
@implementation ServicesInterface

-(void)getServicesList
{
    self.interfaceUrl = [NSString stringWithFormat:@"%@api/%@/services",BASE_INTERFACE_DOMAIN, MALL_CODE];
    self.baseDelegate = self;
    [self connect];
}

#pragma mark - BaseInterfaceDelegate
//{
//    
//    "services": [
//                 {
//                     "picUrl": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//                     "link": "http://misc.360buyimg.com/lib/",
//                     "itemType": 1,
//                     "name": "美食",
//                     "itemId": "123"
//                 },
//                 {
//                     "picUrl": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//                     "link": "http://misc.360buyimg.com/lib/",
//                     "itemType": 1,
//                     "name": "美食",
//                     "itemId": "123"
//                 },
//                 {
//                     "picUrl": "http://misc.360buyimg.com/lib/img/e/logo-201305.png",
//                     "link": "http://misc.360buyimg.com/lib/",
//                     "itemType": 1,
//                     "name": "美食",
//                     "itemId": "123"
//                 }
//                 ],
//    "totalCount": 3
//    
//}
-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[[NSString alloc] initWithData:[request responseData] encoding:NSUTF8StringEncoding] autorelease];
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSMutableArray *resultList = [NSMutableArray array];
        NSInteger totalCount = 0;
        if (jsonObj && [[jsonObj objectForKey:@"totalCount"] integerValue] > 0) {
            totalCount = [[jsonObj objectForKey:@"totalCount"] integerValue];
            
            NSArray *servicesArray = [jsonObj objectForKey:@"services"];
            if (servicesArray) {
                for (NSDictionary *serviceDict in servicesArray) {
                    ServiceModel *service = [[[ServiceModel alloc] initWithJsonMap:serviceDict] autorelease];
                    [resultList addObject:service];
                }
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(getServicesListDidFinished:totalCount:)]) {
            [self.delegate getServicesListDidFinished:resultList
                                          totalCount:totalCount];
        }
    }
}

-(void)requestIsFailed:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(getServicesListDidFailed:)]) {
        [self.delegate getServicesListDidFailed:[NSString stringWithFormat:@"获取失败！(%@)",error]];
    }
}

-(void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}

@end
