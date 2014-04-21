
#import "DataType.h"
#import "MobiConnection.h"

@protocol MBSIconDownloaderDelegate;
@protocol ImgDownloaderDelegate;

enum DownloadStatus {
    DOWNLOAD_SUCCESSFUL = 1,
    DOWNLOAD_FAIL = 2,
    DOWNLOAD_PROCESSING = 3,
    DOWNLOAD_CANCELED = 4,
    };

@interface imagesDownloader : NSObject {
}

- (void)trimCache;
- (UIImage*)loadImageFromCache:(NSString*) url;
@end

@interface MBSIconDownloader : imagesDownloader
{
    NSIndexPath *indexPathInTableView;
    id <MBSIconDownloaderDelegate> delegate;
    MobiConnection *iconDownloadConn;
    NSString *imageUrl;
}

@property (nonatomic, retain) NSIndexPath *indexPathInTableView;
@property (nonatomic, assign) id <MBSIconDownloaderDelegate> delegate;

@property (nonatomic, retain) MobiConnection *iconDownloadConn;

@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, assign) BOOL *bCacheOnly;
@property (nonatomic, readonly) enum DownloadStatus status;

- (void)startDownload;
- (void)cancelDownload;

@end


@interface ImgDownloader : imagesDownloader
{
    NSInteger imgIndex;
    id <ImgDownloaderDelegate> delegate;
    MobiConnection *imageConnection;
    NSString *imageUrl;
}

@property (nonatomic, assign) NSInteger imgIndex;
@property (nonatomic, assign) id <ImgDownloaderDelegate> delegate;
@property (nonatomic, retain) MobiConnection *imageConnection;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, assign) BOOL *bCacheOnly;

- (void)startDownload;
- (void)cancelDownload;

@end