//
//  ServerSpecial.h
//  SmartMall
//
//  Created by sunyifei on 12/30/11.
//  Copyright (c) 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerSpecial : NSObject <UIAlertViewDelegate> { //ParseOperationDelegate
}


+ (ServerSpecial *)getInstance;
+ (NSString *)serverAddress;
+ (void)refreshServerIp;
@end
