//
//  SingletonHelpers.h
//  MBSMapSample
//
//  Created by sunyifei on 10/24/12.
//
//

#import <Foundation/Foundation.h>

@class MBSIconDownloader;
@interface SingletonHelpers : NSObject

+ (MBSIconDownloader*)shareIconDownloader;
@end
