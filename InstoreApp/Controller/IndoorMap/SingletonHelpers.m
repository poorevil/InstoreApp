//
//  SingletonHelpers.m
//  MBSMapSample
//
//  Created by sunyifei on 10/24/12.
//
//

#import "SingletonHelpers.h"
#import "MBSIconDownloaderDelegate.h"

@implementation SingletonHelpers
static MBSIconDownloader *_shareIconDownloader = nil;


// shared Icon downloader
+ (MBSIconDownloader*)shareIconDownloader
{
    if (_shareIconDownloader == nil) {
        _shareIconDownloader = [[MBSIconDownloader alloc] init];
    }
    return _shareIconDownloader;
}

- (void)dealloc
{
    [_shareIconDownloader release];
    _shareIconDownloader = nil;
    
    [super dealloc];
}

@end
