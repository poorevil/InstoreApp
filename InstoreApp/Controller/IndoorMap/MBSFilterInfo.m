//
//  MBSFilterInfo.m
//  MBSMapSample
//
//  Created by sunyifei on 11/15/12.
//
//

#import "MBSFilterInfo.h"

@implementation MBSFilterInfo
@synthesize filterString, fIsFurtherFilter;

- (void)dealloc
{
	self.filterString = nil;
	
    [super dealloc];
}

@end
