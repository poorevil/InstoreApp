//
//  IconDictManager.h
//  MBSMap
//
//  Created by sunyifei on 9/15/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseOperation.h"

@class SVGIcon, MobiConnection;
@interface IconDictManager : NSObject <ParseOperationDelegate> {
}

@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSMutableDictionary *iconDict1;
@property (nonatomic, retain) NSMutableDictionary *iconDict2;

+ (IconDictManager *)getInstance;
+ (IconDictManager *)getInstanceIfExists;

- (void)initIconsFromServer;
- (void)setSupportAirPortAndTrain:(BOOL)fValue;

- (int)getIconInitLevel;
- (NSInteger)getIconDisplayLevel:(NSString *)key;
- (SVGIcon *)getIconByKey:(NSString *)key;

@end
