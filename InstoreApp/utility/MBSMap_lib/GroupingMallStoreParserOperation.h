//
//  GroupingMallStoreParserOperation.h
//  SmartMall
//
//  Created by dujianping on 12/27/12.
//
//

#import "ParseOperation.h"

#import "MBSMapViewController.h"

@interface GroupingMallStoreParserOperation : ParseOperation{
}

-(id)initWithData:(NSData *)data  delegate:(id<ParseOperationDelegate>)theDelegate;

@end
