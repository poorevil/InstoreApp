//
//  MyClass.h
//  SmartMall
//
//  Created by dujianping on 8/26/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParseOperation.h"

@interface GeneralListParserOperation : ParseOperation

-(id)initWithData:(NSData *)data DataType: (enum DATA_TYPE)dataType delegate:(id<ParseOperationDelegate>)theDelegate;

@end
