//
//  MBSFloorParserOperation.h
//  SmartMall
//
//  Created by sunyifei on 1/5/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseOperation.h"

@interface MBSFloorParserOperation : ParseOperation {
    
    enum DATA_TYPE dataType;
    int mapInstanceTag;
    BOOL ParsedMap;
}

-(id)initWithData:(NSData *)data DataType: (enum DATA_TYPE)tempDataType delegate:(id<ParseOperationDelegate>)theDelegate;

@end
