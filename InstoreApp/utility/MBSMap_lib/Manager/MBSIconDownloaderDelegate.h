//
//  MBSIconDownloaderDelegate.h
//  MBSMapViewController
//
//  Created by sunyifei on 11/12/12.
//
//

#import <Foundation/Foundation.h>


@protocol MBSIconDownloaderDelegate

- (void)iconDidLoad:(NSIndexPath *)indexPath downloadedIcon:(UIImage *)iconObj;
- (void)iconLoadFail:(NSIndexPath *)indexPath;
@end

@protocol ImgDownloaderDelegate

- (void)imgDidLoad:(NSInteger)imgIndex downloadedImage:(UIImage *)imageObj;

@optional
- (void)imgLoadFail:(NSInteger)imgIndex;

@end