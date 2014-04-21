//
//  ImageDownloaderImpl.h
//
//  Created by Hary on 11-11-11.
//  Copyright 2011年 __www.widitu.net__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"
#import "CacheConfiguration.h"
///---------------------------------------------------------------

@interface ImageTask : NSObject {

    NSString* url_; 
    NSURLConnection* connection_; 
    
    NSMutableData *receivedData_; 
    
    id<ImageDownloaderDelegate> delegate_; 
    
}
@property(nonatomic,copy) NSString *url; 
@property(nonatomic,retain) NSURLConnection *connection; 
@property(nonatomic,retain) NSMutableData *receivedData; 
@property(nonatomic,assign) id<ImageDownloaderDelegate> delegate; 

@end

///---------------------------------------------------------------
typedef enum {
    Running,  //正在执行一个下载任务
    Waiting,  //当前无正在下载任务，正在等待
    Pause,    //下载暂停
}DownloaderStatus;

@interface ImageDownloaderImpl : NSObject<ImageDownloader> { 
    // each object is an image task
    NSMutableArray *imageTaskArray_; 
    
    // current status
    DownloaderStatus status_; 
    
    // timer
    NSTimer *timer;     
    
    CacheConfiguration* imgCacheConfig_;

}

//按策略清理缓存
- (void)trimCache;

@property(nonatomic,retain) NSMutableArray *imageTaskArray; 

@end
