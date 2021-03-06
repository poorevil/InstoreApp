//
//  PhotoAlbumViewController.m
//  VDiskMobile
//
//  Created by hanchao on 13-8-22.
//
//

#import "PhotoViewController.h"

#import "NIPhotoAlbumScrollView.h"
#import "PhotoAlbumToolBarView.h"

#import "NIPhotoScrollView.h"

#import "MBProgressHUD.h"

#import "ImageMetaDataLoader.h"
#import "TileView.h"
#import <ImageIO/ImageIO.h>

#import "ImageMetadata.h"
#import "NSString+Crypto.h"

#import "ASINetworkQueue.h"
#import "ASIHTTPRequest.h"




#define	kSMALLJPGPATH(__src)    [[(__src) stringByDeletingPathExtension] stringByAppendingString:@"-thumb-small.jpg"]


@interface PhotoViewController () <NIPhotoAlbumScrollViewDelegate,NIPhotoAlbumScrollViewDataSource,UIActionSheetDelegate
//,VdiskRestClientDelegate,,ShareDelegate
,MBProgressHUDDelegate,UIDocumentInteractionControllerDelegate,ASIHTTPRequestDelegate,ASIProgressDelegate>{
    
    BOOL _isLoged;
    
}

@property (nonatomic, retain) ASINetworkQueue *networkQueue;

@property (nonatomic,retain) ImageMetadata *metadata;//当前显示的图片
@property (nonatomic,retain) NSMutableArray *fileListData;//所有图片

@property (nonatomic, retain) UIActionSheet *actionSheet;

//@property (nonatomic,retain) VdiskDownloadOperation *downloadOperation;

@property (nonatomic,retain) PhotoAlbumToolBarView *mPhotoAlbumToolBarView;
@property (nonatomic,retain) NIPhotoAlbumScrollView *photoAlbum;

@property (nonatomic,assign) NSInteger centerPhotoIndex;//第一张需要显示的图片

@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) MBProgressHUD *operationProgressHud;

//@property (nonatomic, strong) Shares *shares;

@property (nonatomic, retain) UIDocumentInteractionController *docController;

@property (nonatomic,assign) PhotoViewController *blockDelegate;//用于下载原图operation的block

@end

@implementation PhotoViewController

- (id)init {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.blockDelegate = self;
        _showDirectly = NO;
        _shareActionLock = NO;
    }
    
    return self;
}

-(void)loadView
{
    [super loadView];
    
    /*
     * init photoAlbumScrollview
     */
    self.photoAlbum = [[[NIPhotoAlbumScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    self.photoAlbum.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.photoAlbum.dataSource = self;
    self.photoAlbum.delegate = self;
    self.photoAlbum.loadingImage = [UIImage imageWithContentsOfFile:
                                    NIPathForBundleResource(nil, @"NimbusPhotos.bundle/gfx/default.png")];
    self.photoAlbum.zoomingAboveOriginalSizeIsEnabled=YES;
    self.photoAlbum.zoomingIsEnabled = YES;
    self.photoAlbum.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.photoAlbum];
    
    [self.photoAlbum reloadData];
    
    self.mPhotoAlbumToolBarView = [[[NSBundle mainBundle] loadNibNamed:@"PhotoAlbumToolBarView"
                                                                 owner:self
                                                               options:nil] objectAtIndex:0];
    CGRect frame = self.mPhotoAlbumToolBarView.frame;
    frame.origin = CGPointMake(0, self.view.frame.size.height - frame.size.height);
    frame.size.width = self.view.frame.size.width;
    self.mPhotoAlbumToolBarView.frame = frame;
    
    [self.view addSubview:self.mPhotoAlbumToolBarView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#ifdef __IPHONE_7_0
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    if ([self.fileListData count] > 0 && self.metadata != nil)
        _centerPhotoIndex = [self.fileListData indexOfObject:self.metadata];
    
    [self setTapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didBecomeActivity:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
    self.networkQueue = [ASINetworkQueue queue];
    self.networkQueue.delegate = self;
    self.networkQueue.shouldCancelAllRequestsOnFailure = NO;
    [self.networkQueue setRequestDidFinishSelector:@selector(requestFinished:)];
    [self.networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
//    [self.networkQueue setQueueDidFinishSelector:@selector(queueFinished:)];
    [[self networkQueue] go];
}

-(void)didBecomeActivity:(NSNotification *)notification
{
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    [self.navigationController setNavigationBarHidden:YES];
    
    //移到第一张照片位置
    self.photoAlbum.centerPageIndex=self.centerPhotoIndex;
    
    [self setupBarButtonsByCurrentMetaData];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        [self.navigationController setNavigationBarHidden:NO];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0f) {
//        [kShareAppDelegate.ipadviewController willAnimateRotationToInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation  duration:1];
//        [kShareAppDelegate.detailIpadViewController willAnimateRotationToInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation  duration:1];
//        kShareAppDelegate.masterViewController.fixBug = YES;
//        [kShareAppDelegate.masterViewController willAnimateRotationToInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation  duration:1];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self.networkQueue cancelAllOperations];
    self.networkQueue.delegate = nil;
    self.networkQueue = nil;
    
    self.blockDelegate = nil;
    
    self.photoAlbum.delegate = nil;
    self.fileListData = nil;
    self.metadata = nil;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    self.photoAlbum = nil;
    
    self.actionSheet.delegate = nil;
    self.actionSheet = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.docController = nil;
    
    self.hud.delegate = nil;
    self.hud = nil;
    
    self.operationProgressHud.delegate = nil;
    self.operationProgressHud = nil;
    
    self.mPhotoAlbumToolBarView = nil;
    
    self.currentImageUrl = nil;
    self.imageListUrl = nil;
    
    [super dealloc];
}

#pragma mark - override getter and setter method
-(void)setCurrentImageUrl:(NSString *)currentImageUrl
{
    [_currentImageUrl release];
    _currentImageUrl = [currentImageUrl retain];
    
    self.metadata = [[[ImageMetadata alloc] initWithLine:currentImageUrl] autorelease];
}

-(void)setImageListUrl:(NSMutableArray *)imageListUrl
{
    [_imageListUrl release];
    _imageListUrl = [imageListUrl retain];
    
    self.fileListData = [NSMutableArray array];
    
    for (NSString *url in imageListUrl) {
        ImageMetadata *metadata = [[ImageMetadata alloc] initWithLine:url];
        [self.fileListData addObject:metadata];
        [metadata release];
    }
}

#pragma mark - screen autorotate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NIIsSupportedOrientation(toInterfaceOrientation);
}

- (void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation
                                duration: (NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.photoAlbum willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
}

- (void)willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation
                                         duration: (NSTimeInterval)duration {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.actionSheet dismissWithClickedButtonIndex:0 animated:NO];
        self.actionSheet = nil;
        _shareActionLock = NO;
        
//        [kShareAppDelegate.readerPopover dismissPopoverAnimated:NO];
    }
    
    [self.photoAlbum willAnimateRotationToInterfaceOrientation: toInterfaceOrientation
                                                      duration: duration];
    
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];
    
}


#pragma mark - private method

//根据情况初始化按钮
-(void)setupBarButtonsByCurrentMetaData
{
    ImageMetadata *metadata = [self.fileListData objectAtIndex:self.photoAlbum.centerPageIndex];
    /*
     * 判断centerButton和rightButton是否可用
     */
    for (NIPhotoScrollView *page in self.photoAlbum.visiblePages) {
        if (page.pageIndex == self.photoAlbum.centerPageIndex) {
            if (page.hud != nil && page.hud.progress != 0 && page.hud.progress != 1) {
//                self.mPhotoAlbumToolBarView.centerBtn.enabled = NO;
                self.mPhotoAlbumToolBarView.rightBtn.enabled = NO;
            }else{
//                self.mPhotoAlbumToolBarView.centerBtn.enabled = YES;
                self.mPhotoAlbumToolBarView.rightBtn.enabled = YES;
            }
            
            if (metadata.hasCache || [[NSFileManager defaultManager] fileExistsAtPath:kSMALLJPGPATH(metadata.cachePath)]) {
                self.mPhotoAlbumToolBarView.rightBtn.enabled = YES;
            }else{
                self.mPhotoAlbumToolBarView.rightBtn.enabled = NO;
            }
            
            break;
        }
    }
    
    //更新当前图片索引
    self.mPhotoAlbumToolBarView.indexLabel.text = [NSString stringWithFormat:@"%d / %d",self.photoAlbum.centerPageIndex+1,self.fileListData.count];
    
//    [self.mPhotoAlbumToolBarView.leftBtn removeTarget:nil
//                                               action:NULL
//                                     forControlEvents:UIControlEventAllEvents];
//    [self.mPhotoAlbumToolBarView.centerBtn removeTarget:nil
//                                                 action:NULL
//                                       forControlEvents:UIControlEventAllEvents];
//    [self.mPhotoAlbumToolBarView.rightBtn removeTarget:nil
//                                                action:NULL
//                                      forControlEvents:UIControlEventAllEvents];
    
    if ([metadata hasCache]) {//若文件已经下载
        [self.mPhotoAlbumToolBarView.rightBtn setImage:[UIImage imageNamed:@"more_light"]
                                              forState:UIControlStateNormal];
        [self.mPhotoAlbumToolBarView.rightBtn addTarget:self
                                                 action:@selector(rightAction:)
                                       forControlEvents:UIControlEventTouchUpInside];
    }
    
    
//    if ([metadata hasCache]) {//若文件已经下载
//        if (!(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )) {//&& kShareAppDelegate.isNewIpad
//            
//            self.mPhotoAlbumToolBarView.centerBtn.hidden = NO;
//            /*
//             * 判断是否为收藏文件
//             */
//            FavoriteModel *favoriteModel = [[FavoriteModel alloc] init];
//            if ([favoriteModel isStared:metadata]) {//已收藏
//                
//                [self.mPhotoAlbumToolBarView.centerBtn setImage:[UIImage imageNamed:@"star_light"]
//                                                       forState:UIControlStateNormal];
//                
//            } else {//未收藏
//                
//                [self.mPhotoAlbumToolBarView.centerBtn setImage:[UIImage imageNamed:@"unstar_light"]
//                                                       forState:UIControlStateNormal];
//            }
//            
//            [self.mPhotoAlbumToolBarView.centerBtn addTarget:self
//                                                      action:@selector(favFile:)
//                                            forControlEvents:UIControlEventTouchUpInside];
//            
//            [favoriteModel release];
//            
//        }else{
//            
//            self.mPhotoAlbumToolBarView.centerBtn.hidden = YES;
//        }
//        
//    }else{
//        
//        self.mPhotoAlbumToolBarView.centerBtn.hidden = NO;
//        
//        [self.mPhotoAlbumToolBarView.centerBtn setImage:[UIImage imageNamed:@"down_light"]
//                                               forState:UIControlStateNormal];
//        
//        [self.mPhotoAlbumToolBarView.centerBtn addTarget:self
//                                                  action:@selector(downloadFile:)
//                                        forControlEvents:UIControlEventTouchUpInside];
//        
//    }
    
//    if (self.showDirectly) {
//        
//        self.mPhotoAlbumToolBarView.centerBtn.hidden = YES;//若showDirectly==yes 则没有加星、下载功能
//        
//        [self.mPhotoAlbumToolBarView.leftBtn setImage:[UIImage imageNamed:@"save2vdisk_light"]
//                                             forState:UIControlStateNormal];
//        [self.mPhotoAlbumToolBarView.leftBtn addTarget:self
//                                                action:@selector(leftAction:)
//                                      forControlEvents:UIControlEventTouchUpInside];
//        
//        [self.mPhotoAlbumToolBarView.rightBtn setImage:[UIImage imageNamed:@"more_light"]
//                                              forState:UIControlStateNormal];
//        [self.mPhotoAlbumToolBarView.rightBtn addTarget:self
//                                                 action:@selector(rightAction:)
//                                       forControlEvents:UIControlEventTouchUpInside];
//        
//    } else {
//        
//        //        self.mPhotoAlbumToolBarView.centerBtn.hidden = NO;
//        
//        if ([metadata isKindOfClass:[VdiskSharesMetadata class]]) {
//            
//            [self.mPhotoAlbumToolBarView.leftBtn setImage:[UIImage imageNamed:@"save2vdisk_light"]
//                                                 forState:UIControlStateNormal];
//            [self.mPhotoAlbumToolBarView.leftBtn addTarget:self
//                                                    action:@selector(leftAction:)
//                                          forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            if ([(VdiskSharesMetadata *)metadata sharesMetadataType] == kVdiskSharesMetadataTypeFromFriend) {
//                
//                [self.mPhotoAlbumToolBarView.rightBtn setImage:[UIImage imageNamed:@"more_light"]
//                                                      forState:UIControlStateNormal];
//                [self.mPhotoAlbumToolBarView.rightBtn addTarget:self
//                                                         action:@selector(rightAction:)
//                                               forControlEvents:UIControlEventTouchUpInside];
//                
//            } else if ([(VdiskSharesMetadata *)metadata sharesMetadataType] == kVdiskSharesMetadataTypeLinkcommon) {
//                
//                [self.mPhotoAlbumToolBarView.rightBtn setImage:[UIImage imageNamed:@"more_light"]
//                                                      forState:UIControlStateNormal];
//                [self.mPhotoAlbumToolBarView.rightBtn addTarget:self
//                                                         action:@selector(rightAction:)
//                                               forControlEvents:UIControlEventTouchUpInside];
//                
//            } else {
//                
//                [self.mPhotoAlbumToolBarView.rightBtn setImage:[UIImage imageNamed:@"more_light"]
//                                                      forState:UIControlStateNormal];
//                [self.mPhotoAlbumToolBarView.rightBtn addTarget:self
//                                                         action:@selector(rightAction:)
//                                               forControlEvents:UIControlEventTouchUpInside];
//            }
//            
//        } else {
//            
//            
//            [self.mPhotoAlbumToolBarView.leftBtn setImage:[UIImage imageNamed:@"share_light"]
//                                                 forState:UIControlStateNormal];
//            [self.mPhotoAlbumToolBarView.leftBtn addTarget:self
//                                                    action:@selector(leftAction:)
//                                          forControlEvents:UIControlEventTouchUpInside];
//            
//            [self.mPhotoAlbumToolBarView.rightBtn setImage:[UIImage imageNamed:@"more_light"]
//                                                  forState:UIControlStateNormal];
//            [self.mPhotoAlbumToolBarView.rightBtn addTarget:self
//                                                     action:@selector(rightAction:)
//                                           forControlEvents:UIControlEventTouchUpInside];
//            
//        }
//        
//    }
    
    
}

//- (void)leftAction:(id)sender {
//    
//    VdiskMetadata *metadata = [self.fileListData objectAtIndex:self.photoAlbum.centerPageIndex];
//    
//    if (self.showDirectly) {
//        
//        [self selectDestinationFolder];
//        
//    } else {
//        
//        if ([metadata isKindOfClass:[VdiskSharesMetadata class]]) {
//            
//            if ([(VdiskSharesMetadata *)metadata sharesMetadataType] == kVdiskSharesMetadataTypeFromFriend) {
//                
//                [self selectDestinationFolder];
//                
//            } else if ([(VdiskSharesMetadata *)metadata sharesMetadataType] == kVdiskSharesMetadataTypeLinkcommon) {
//                
//                [self selectDestinationFolder];
//                
//            } else {
//                
//                [self selectDestinationFolder];
//            }
//            
//        } else {
//            
//            [self shareTo];
//        }
//        
//    }
//}
//
- (void)rightAction:(id)sender {
    
    self.actionSheet = [[[UIActionSheet alloc] initWithTitle:nil
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:@"用其他应用打开", @"保存到相册", nil] autorelease];

        

    
    self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        CGPoint pointInViewCoords = [self.mPhotoAlbumToolBarView convertPoint:self.mPhotoAlbumToolBarView.rightBtn.frame.origin
                                                                       toView:self.view];
        [self.actionSheet showFromRect:CGRectMake(pointInViewCoords.x,
                                                  pointInViewCoords.y,
                                                  self.mPhotoAlbumToolBarView.rightBtn.frame.size.width,
                                                  self.mPhotoAlbumToolBarView.rightBtn.frame.size.height)
                                inView:self.view
                              animated:YES];
        
    } else {
        
        [self.actionSheet showInView:self.navigationController.view];
    }
    
    _shareActionLock = YES;
}


#define kIMAGE_PREFIX @"bigimage_"
#define kIMAGE_CATCHE_PATH ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"tiledImage"])

#define kTILED_MIN_WIDTH            1024
#define kTILED_MIN_HEIGHT           1024
#define kTILED_MIN_PIXEL            (kTILED_MIN_WIDTH * kTILED_MIN_HEIGHT)

#define kUSE_TILED_LAYER(_rect)     ((_rect.size.height * _rect.size.width) >= kTILED_MIN_PIXEL ? YES : NO)

////下载原图
//-(BOOL)downloadFile:(id)sender
//{
//    ImageMetadata *metadata = [self.fileListData objectAtIndex:self.photoAlbum.centerPageIndex];
//    
////    _downloadOperation = [[VdiskDownloadOperation alloc] initWithMetadata:metadata delegate:self];
//    
//    __block typeof(self.blockDelegate) bself = self.blockDelegate;
//    _downloadOperation.downloadCompletedBlock = ^(VdiskDownloadOperation *downloadOperation){
//        
//        UIImage *image = [bself fetchBigImageByMetadata:downloadOperation.metadata];
//        
//        if (image) {
//            
//            image = [TileView fixOrientation:image];
//            
//            if (downloadOperation.isCancelled || downloadOperation.isFinished) return;
//            
//            NSString *generatedFilePath = [NSString stringWithFormat:@"%@/generated",
//                                           [kIMAGE_CATCHE_PATH stringByAppendingPathComponent:image.accessibilityIdentifier]];
//            
//            /*
//             * 若generated文件不存在，说明需要生成tile图片文件
//             */
//            if(![[NSFileManager defaultManager] fileExistsAtPath:generatedFilePath]){
//                
//                CGSize size = (CGSize){kTILED_MIN_WIDTH, kTILED_MIN_HEIGHT};//tile目标size大小
//                
//                CGFloat cols = [image size].width / size.width;
//                CGFloat rows = [image size].height / size.height;
//                
//                NSString* directoryPath = [kIMAGE_CATCHE_PATH stringByAppendingPathComponent:image.accessibilityIdentifier];
//                
//                if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath]) {
//                    [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES
//                                                               attributes:nil error:nil];
//                    
//                }
//                
//                int fullColumns = floorf(cols);
//                int fullRows = floorf(rows);
//                
//                CGFloat remainderWidth = [image size].width - (fullColumns * size.width);
//                CGFloat remainderHeight = [image size].height -(fullRows * size.height);
//                
//                
//                if (cols > fullColumns) fullColumns++;
//                if (rows > fullRows) fullRows++;
//                
//                CGImageRef fullImage = [image CGImage];
//                
//                /*
//                 *  构造切图子线程
//                 */
//                NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//                queue.maxConcurrentOperationCount = 5;
//                
//                NSBlockOperation *generatedFileblockOper = [NSBlockOperation blockOperationWithBlock:^{
//                    //生成标记文件
//                    NSString *generatedPath = [NSString stringWithFormat:@"%@/generated",
//                                               [kIMAGE_CATCHE_PATH stringByAppendingPathComponent:image.accessibilityIdentifier]];
//                    
//                    [@"1" writeToFile:generatedPath
//                           atomically:NO
//                             encoding:NSUTF8StringEncoding
//                                error:nil];
//                }];
//                [queue addOperation:generatedFileblockOper];
//                
//                for (int y = 0; y < fullRows; ++y) {
//                    
//                    if ([downloadOperation isCancelled] || downloadOperation.isFinished) break;//stop operation
//                    
//                    for (int x = 0; x < fullColumns; ++x) {
//                        
//                        if ([downloadOperation isCancelled] || downloadOperation.isFinished) break;//stop operation
//                        
//                        CGSize tileSize = size;
//                        if (x + 1 == fullColumns && remainderWidth > 0) {
//                            // Last column
//                            tileSize.width = remainderWidth;
//                        }
//                        if (y + 1 == fullRows && remainderHeight > 0) {
//                            // Last row
//                            tileSize.height = remainderHeight;
//                        }
//                        
//                        NSBlockOperation *blockOper = [NSBlockOperation blockOperationWithBlock:^{
//                            
//                            CGRect imageRect = (CGRect){{x*size.width, y*size.height},tileSize};
//                            CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage,imageRect);
//                            
//                            
//                            NSString *path = [NSString stringWithFormat:@"%@/%@%d_%d.png",directoryPath, kIMAGE_PREFIX, x, y];
//                            
//                            NSURL *url = [NSURL fileURLWithPath:path];
//                            CGImageDestinationRef myImageDest = CGImageDestinationCreateWithURL((CFURLRef)url, kUTTypeJPEG, 1, NULL);
//                            UIImage *image = [UIImage imageWithCGImage:tileImage];
//                            CGImageDestinationAddImage(myImageDest, [image CGImage], NULL);
//                            CGImageDestinationFinalize(myImageDest);
//                            CFRelease(myImageDest);
//                            CGImageRelease(tileImage);
//                            
//                            
//                            
//                        }];
//                        
//                        [queue addOperation:blockOper];
//                        [generatedFileblockOper addDependency:blockOper];
//                        
//                    }
//                    
//                }
//                
//                
//                //等待queue结束
//                while (queue.operationCount > 0) {
//                    
//                    if (downloadOperation.isCancelled || downloadOperation.isFinished){
//                        
//                        [queue cancelAllOperations];
//                    }
//                }
//                
//                [queue release];
//            }
//        }
//        
//    };
//    
//    [_downloadOperation start];
//    
//    
//    if (!self.operationProgressHud) {
//        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//            
//            self.operationProgressHud = [[[MBProgressHUD alloc] initWithView:kShareAppDelegate.detailViewController.navigationController.view] autorelease];
//            [self.photoAlbum addSubview:self.operationProgressHud];
//            
//        } else {
//            
//            self.operationProgressHud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
//            [self.photoAlbum addSubview:self.operationProgressHud];
//        }
//        
//        self.operationProgressHud.mode = MBProgressHUDModeAnnularDeterminate;
//        self.operationProgressHud.dimBackground = NO;
//        self.operationProgressHud.delegate = self;
//        [self.operationProgressHud show:YES];
//    }
//    
//    self.operationProgressHud.progress = 0.01f;
//    
//    
//    
//    return NO;
//}

-(void)setTapGesture
{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.photoAlbum addGestureRecognizer:doubleTap];
    [doubleTap release];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.photoAlbum addGestureRecognizer:tapGesture];
    [tapGesture requireGestureRecognizerToFail:doubleTap];
    [tapGesture release];
}

-(void)tapAction:(UITapGestureRecognizer *)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //        [self.navigationController popViewControllerAnimated:YES];
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [[self navigationController] popViewControllerAnimated:NO];
        
    }else{
        [self.navigationController dismissModalViewControllerAnimated:YES];
    }
}


-(void)doubleTapAction:(UITapGestureRecognizer *)sender
{
    //do nothing
}

// ==============================================================
// resizedImage
// ==============================================================
// Return a scaled down copy of the image.

UIImage* resizedImage(UIImage *inImage, CGRect thumbRect)
{
    CGImageRef	imageRef = [inImage CGImage];
    CGImageAlphaInfo	alphaInfo = CGImageGetAlphaInfo(imageRef);
    // There's a wierdness with kCGImageAlphaNone and CGBitmapContextCreate
    // see Supported Pixel Formats in the Quartz 2D Programming Guide
    // Creating a Bitmap Graphics Context section
    // only RGB 8 bit images with alpha of kCGImageAlphaNoneSkipFirst, kCGImageAlphaNoneSkipLast, kCGImageAlphaPremultipliedFirst,
    // and kCGImageAlphaPremultipliedLast, with a few other oddball image kinds are supported
    // The images on input here are likely to be png or jpeg files
    if (alphaInfo == kCGImageAlphaNone)
        alphaInfo = kCGImageAlphaNoneSkipLast;
    
    // Build a bitmap context that's the size of the thumbRect
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                thumbRect.size.width,	// width
                                                thumbRect.size.height,	// height
                                                CGImageGetBitsPerComponent(imageRef),	// really needs to always be 8
                                                4 * thumbRect.size.width,	// rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                alphaInfo
                                                );
    
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    // Get an image from the context and a UIImage
    CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
    UIImage*	result = [UIImage imageWithCGImage:ref scale:1.0 orientation:inImage.imageOrientation];
    
    CGContextRelease(bitmap);	// ok if NULL
    CGImageRelease(ref);
    
    return result;
}

#pragma mark - NIPhotoAlbumScrollViewDataSource
- (UIImage *)photoAlbumScrollView: (NIPhotoAlbumScrollView *)photoAlbumScrollView
                     photoAtIndex: (NSInteger)photoIndex
                        photoSize: (NIPhotoScrollViewPhotoSize *)photoSize
                        isLoading: (BOOL *)isLoading
          originalPhotoDimensions: (CGSize *)originalPhotoDimensions
{
    UIImage *image = nil;
    
    ImageMetadata *metadata = [self.fileListData objectAtIndex:photoIndex];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:kSMALLJPGPATH(metadata.cachePath)]){
        if(photoIndex != photoAlbumScrollView.centerPageIndex) {
            
            //下载“m”缩略图
//            [_restClient loadThumbnailWithMetadata:metadata
//                                            ofSize:@"m" //size   字符串（s,m,l,xl）    s:60x60,m:100x100,l:640x480,xl:1024x768
//                                          intoPath:kICONPNGRAWPATH([metadata cachePath:YES],@"m")
//                                            params:nil];
            
            ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/100*100.png",
                                                                                           metadata.link]]];
            
            [request setDownloadProgressDelegate:self];
            request.userInfo = @{@"metadata": metadata, @"size":@"m"};
            [request setDownloadDestinationPath:kSMALLJPGPATH([metadata cachePath])];
            request.showAccurateProgress = YES;
            [self.networkQueue addOperation:request];
        }
    }else{
        
        image = [UIImage imageWithContentsOfFile:kSMALLJPGPATH(metadata.cachePath)];
        image.accessibilityIdentifier = [kSMALLJPGPATH(metadata.cachePath) MD5EncodedString];
        
        *photoSize = NIPhotoScrollViewPhotoSizeThumbnail;
        *originalPhotoDimensions = image.size;
    }
    
    *isLoading = YES;
    
    
    return image;
}

#pragma mark - NIPagingScrollViewDelegate
- (void)pagingScrollViewDidChangePages:(NIPagingScrollView *)pagingScrollView
{
    self.centerPhotoIndex = self.photoAlbum.centerPageIndex;
    
    NSInteger currentPageIndex = pagingScrollView.centerPageIndex;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(loadBigImage:) withObject:[NSNumber numberWithInt:currentPageIndex] afterDelay:0.3];
    
}

//读大图
-(void)loadBigImage:(NSNumber *)pageIndexNumber
{
    NSInteger pageIndex = [pageIndexNumber integerValue];//加载的页数
    
    NIPhotoScrollViewPhotoSize currentPhotoSize = NIPhotoScrollViewPhotoSizeUnknown;
    
    for (NIPhotoScrollView *page in self.photoAlbum.visiblePages) {
        
        if (page.pageIndex == pageIndex) {
            
            currentPhotoSize = page.photoSize;
            
            break;
        }
    }
    
    if (currentPhotoSize != NIPhotoScrollViewPhotoSizeOriginal) {
        
        NIPhotoScrollView *psv = (NIPhotoScrollView *)[self.photoAlbum pagingScrollView:self.photoAlbum pageViewForIndex:pageIndex];
        if (psv.photoSize < NIPhotoScrollViewPhotoSizeOriginal ) {
            
            ImageMetadata *metadata = [self.fileListData objectAtIndex:pageIndex];
            
            UIImage *image = [self fetchBigImageByMetadata:metadata];
            
            if (image) {
                if ((image.size.width*image.size.height) >= (1024*1024) ) {
                    NSString *generatedFilePath = [NSString stringWithFormat:@"%@/generated",
                                                   [kIMAGE_CATCHE_PATH stringByAppendingPathComponent:image.accessibilityIdentifier]];
                    
                    /*
                     * 若generated文件不存在，说明需要生成tile图片文件
                     */
                    if(![[NSFileManager defaultManager] fileExistsAtPath:generatedFilePath]){
                        
                        //TODO:[self downloadFile:nil];
                        
                        return;
                    }
                }
                
                [self.photoAlbum didLoadPhoto: image
                                      atIndex: pageIndex
                                    photoSize: NIPhotoScrollViewPhotoSizeOriginal];
            }else{
//                if([[NSFileManager defaultManager] fileExistsAtPath:kSMALLJPGPATH([metadata cachePath])]){
//                    UIImage *smallJpgImage = [UIImage imageWithContentsOfFile:kSMALLJPGPATH(metadata.cachePath)];
//                    smallJpgImage.accessibilityIdentifier = [kSMALLJPGPATH(metadata.cachePath) MD5EncodedString];
//                    
//                    [self.photoAlbum didLoadPhoto: smallJpgImage
//                                          atIndex: pageIndex
//                                        photoSize: NIPhotoScrollViewPhotoSizeOriginal];
//                }else{
                
                    //下载大缩略图
//                    [_restClient loadThumbnailWithMetadata:metadata
//                                                    ofSize:@"l" //size   字符串（s,m,l,xl）    s:60x60,m:100x100,l:640x480,xl:1024x768
//                                                  intoPath:kSMALLJPGPATH([metadata cachePath:YES])
//                                                    params:nil];
                    
                    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:metadata.link]];
                    [request setDownloadProgressDelegate:self];
                    request.userInfo = @{@"metadata": metadata, @"size":@"l"};
                    [request setDownloadDestinationPath:[metadata cachePath]];
                request.showAccurateProgress = YES;
                    [self.networkQueue addOperation:request];
                
                    /*
                     * 更新下载进度
                     */
                    for (NIPhotoScrollView *page in self.photoAlbum.visiblePages) {
                        if (page.pageIndex == pageIndex) {
                            
                            [page setLoadProgress:0.0001f];
                            
                            break;
                        }
                    }
//                }
            }
        }
    }
    
    [self setupBarButtonsByCurrentMetaData];
}

#define kMAX_IMAGE_WIDTH    1024.0f*6
#define kMAX_IMAGE_HEIGHT   1024.0f*6

//根据metadata获取已下载图片
-(UIImage *)fetchBigImageByMetadata:(ImageMetadata *)metadata
{
    UIImage *bigImage = nil;
    
    if (metadata.hasCache) {
        
        ImageMetaDataLoader *imd = [[ImageMetaDataLoader alloc] initWithImageUrl:[NSURL fileURLWithPath:metadata.cachePath]];
        [imd loadImageMateDate];
        
        CGFloat imageWidth = imd.width;
        CGFloat imageHeight = imd.height;
        
        [imd release];
        
        //原图大于1024x1024
        if((imageWidth * imageHeight) > (kMAX_IMAGE_WIDTH * kMAX_IMAGE_HEIGHT)){
            
//            if([[NSFileManager defaultManager] fileExistsAtPath:kORIGNSMALLJPGPATH([metadata cachePath])]){
//                
//                bigImage = [UIImage imageWithContentsOfFile:kORIGNSMALLJPGPATH([metadata cachePath:YES])];
//                bigImage.accessibilityIdentifier = [kORIGNSMALLJPGPATH(metadata.cachePath) MD5EncodedString];
//                
//            }else{
            
                CGFloat rate = (kMAX_IMAGE_WIDTH * kMAX_IMAGE_HEIGHT) / (imageHeight*imageWidth);
                imageWidth *= rate;
                imageHeight *= rate;
                
                UIImage *bigImageTmp = [UIImage imageWithContentsOfFile:metadata.cachePath];
                
                CGRect rect = CGRectMake(0, 0, floorf(imageWidth), floorf(imageHeight));
                bigImage = resizedImage(bigImageTmp, rect);
                bigImage.accessibilityIdentifier = [metadata.cachePath MD5EncodedString];
            
                [UIImageJPEGRepresentation(bigImage, 1) writeToFile:[metadata cachePath] atomically:YES];
//            }
            
        }else{
            
            bigImage = [UIImage imageWithContentsOfFile:metadata.cachePath];
            bigImage.accessibilityIdentifier = [metadata.cachePath MD5EncodedString];
        }
        
    }else{
        
//        if([[NSFileManager defaultManager] fileExistsAtPath:kSMALLJPGPATH([metadata cachePath])]){
//            
//            bigImage = [UIImage imageWithContentsOfFile:kSMALLJPGPATH([metadata cachePath])];
//            bigImage.accessibilityIdentifier = [kSMALLJPGPATH(metadata.cachePath) MD5EncodedString];
//            
//        }else{
//            //啥都不做，留给调用者自己启动网络连接加载网络图片。
//        }
    }
    
    return bigImage;
}


#pragma mark - NIPagingScrollViewDataSource <NSObject>

- (NSInteger)numberOfPagesInPagingScrollView:(NIPagingScrollView *)pagingScrollView
{
    return self.fileListData.count;
}


- (UIView<NIPagingScrollViewPage> *)pagingScrollView:(NIPagingScrollView *)pagingScrollView pageViewForIndex:(NSInteger)pageIndex
{
    return self.photoAlbum== nil?nil:[self.photoAlbum pagingScrollView:pagingScrollView pageViewForIndex:pageIndex];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
	//_shareActionLock = NO;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:NO];
    
    _shareActionLock = NO;
    
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        
        return;
    }
    
	
    ImageMetadata *metadata =  [_fileListData objectAtIndex:self.photoAlbum.centerPageIndex];
    
    DebugLog(@"actionSheet:clickedButtonAtIndex:%@", metadata.filename);
    
    
    if (buttonIndex == 0) {
        
        [self presentOptionsMenu];
        
    } else if (buttonIndex == 1) {
        
        _shareActionLock = NO;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:metadata.cachePath]) {
            
//            if (metadata.totalBytes <= 5*1024*1024) {
//                
//                UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:metadata.cachePath], nil, nil , nil);
//                [self alertTitle:nil message:@"保存成功!"];
//                
//                
//            } else
            if([[NSFileManager defaultManager] fileExistsAtPath:metadata.cachePath]){
                
                UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:metadata.cachePath], nil, nil , nil);
                [self alertTitle:nil message:@"保存成功!"];
                
            } else {
                
                [self alertTitle:@"保存失败" message:@"保存失败"];
            }
            
        } else if ([[NSFileManager defaultManager] fileExistsAtPath:kSMALLJPGPATH(metadata.cachePath)]){
            
            UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:kSMALLJPGPATH(metadata.cachePath)], nil, nil , nil);
            [self alertTitle:nil message:@"保存成功!"];
            
        } else {
            
            [self alertTitle:@"保存失败" message:@"下载还未完成"];
        }
        
    } else {
        
        //TODO:[self sendWeibo];
    }
    
    return;
}


- (void)loading:(NSString *)text {
    
    [_hud hide:NO];
    self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
    [self.navigationController.view addSubview:_hud];
    _hud.dimBackground = YES;
    _hud.delegate = self;
    _hud.labelText = text;
    [_hud show:NO];
}

#pragma mark -
#pragma mark UIDocumentInteractionController

- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller {
    
    _shareActionLock = YES;
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    
    _shareActionLock = NO;
}

- (UIDocumentInteractionController *)docControllerForFile:(NSURL *)fileURL {
	
	UIDocumentInteractionController *docController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    docController.delegate = self;
    
	return docController;
}

- (void)unavailableReader {
	
	[self alertTitle:nil message:@"没有检测到可用的阅读器."];
}

- (void)alertTitle:(NSString *)t message:(NSString *)m {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:t
                                                        message:m
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)presentOptionsMenu {
    
    if (_shareActionLock) {
        
        return;
    }
    
    ImageMetadata *metadata = (ImageMetadata *)[_fileListData objectAtIndex:self.photoAlbum.centerPageIndex];
    
    DebugLog(@"presentOptionsMenu %@", metadata.filename);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (self.docController == nil) {
		
        if ([fm fileExistsAtPath:metadata.cachePath]) {
            
            self.docController = [self docControllerForFile:[NSURL fileURLWithPath:metadata.cachePath]];
            
        } else {
            
            self.docController = [self docControllerForFile:[NSURL fileURLWithPath:kSMALLJPGPATH(metadata.cachePath)]];
        }
		
		[self.docController setName:metadata.filename];
        
    } else {
        
        if ([fm fileExistsAtPath:metadata.cachePath]) {
            
            [self.docController setURL:[NSURL fileURLWithPath:metadata.cachePath]];
            
        } else {
            
            [self.docController setURL:[NSURL fileURLWithPath:kSMALLJPGPATH(metadata.cachePath)]];
        }
		
		[self.docController setName:metadata.filename];
    }
	
    CGPoint pointInViewCoords = [self.mPhotoAlbumToolBarView convertPoint:self.mPhotoAlbumToolBarView.rightBtn.frame.origin
                                                                   toView:self.view];
    
    //	if (![self.docController presentOpenInMenuFromBarButtonItem:_rightItem animated:YES]) {
    if (![self.docController presentOpenInMenuFromRect:CGRectMake(pointInViewCoords.x,
                                                                  pointInViewCoords.y,
                                                                  self.mPhotoAlbumToolBarView.rightBtn.frame.size.width,
                                                                  self.mPhotoAlbumToolBarView.rightBtn.frame.size.height)
                                                inView:self.view
                                              animated:YES]) {
		[self unavailableReader];
		self.docController = nil;
        //kShareAppDelegate.docController = nil;
        
	} else {
        
        // kShareAppDelegate.docController = self.docController;
        _shareActionLock = YES;
    }
    
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
    if (hud == _hud) {
        [_hud removeFromSuperview];
        //        [_hud release];
        //        _hud = nil;
    }else{
        [self.operationProgressHud removeFromSuperview];
        self.operationProgressHud = nil;
    }
}

#pragma mark - alert use hud

- (void)alertWithHUD:(NSString *)message afterDelay:(CGFloat)delay {
    
    [_hud hide:NO];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
        [self.navigationController.view addSubview:_hud];
        
    } else {
        
        self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
        [self.navigationController.view addSubview:_hud];
    }
    
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.dimBackground = NO;
    _hud.delegate = self;
    _hud.labelText = message;
    [_hud show:NO];
    [_hud hide:YES afterDelay:delay];
}

- (void)alertWithHUD:(NSString *)message {
    
    [self alertWithHUD:message afterDelay:0.5];
}



//#pragma mark - VdiskDownloadOperationDelegate
//- (void)downloadOperationFailedWithError:(NSError *)error downloadOperation:(VdiskDownloadOperation *)downloadOperation {
//    
//    [self.operationProgressHud hide:YES];
//    
//    [self downloadFailCode:error.code msg:VdiskErrorMessageWithCode(error)];
//}
//
//- (void)downloadOperationFinished:(VdiskMetadata *)metadata downloadOperation:(VdiskDownloadOperation *)downloadOperation {
//    
//    [self downloadSuccess:metadata];
//    
//    self.operationProgressHud.progress = 1.0f;
//    [self.operationProgressHud hide:YES];
//}
//
//- (void)downloadOperationProgress:(CGFloat)newProgress downloadOperation:(VdiskDownloadOperation *)downloadOperation {
//    
//    if (newProgress < 1) {
//        
//        if (!self.operationProgressHud) {
//            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                
//                self.operationProgressHud = [[[MBProgressHUD alloc] initWithView:kShareAppDelegate.detailViewController.navigationController.view] autorelease];
//                [self.photoAlbum addSubview:self.operationProgressHud];
//                
//            } else {
//                
//                self.operationProgressHud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
//                [self.photoAlbum addSubview:self.operationProgressHud];
//            }
//            
//            self.operationProgressHud.mode = MBProgressHUDModeAnnularDeterminate;
//            self.operationProgressHud.dimBackground = NO;
//            self.operationProgressHud.delegate = self;
//            [self.operationProgressHud show:YES];
//        }
//        
//        self.operationProgressHud.progress = newProgress;
//    }else{
//        
//        //        self.operationProgressHud.progress = 1.0f;
//        //        [self.operationProgressHud hide:YES];
//    }
//    
//}
//
//- (void)downloadFailCode:(int)code msg:(NSString *)msg {
//	
//	[self.navigationItem.rightBarButtonItem setEnabled:YES];
//    
//    if (code == 404) {
//        
//        //        [self failTitle:@"文件下载失败" message:@"您下载的文件不存在，可能已经被删除"];
//        [self alertWithHUD:@"您下载的文件不存在，可能已经被删除"];
//        
//    } else {
//        
//        //        [self failTitle:@"文件下载失败" message:msg];
//        [self alertWithHUD:@"文件下载失败"];
//    }
//}
//
//- (void)downloadSuccess:(VdiskMetadata *)metadata {
//    
//    NSString *extName = @"other";
//    
//    if (((VdiskMetadata *)(metadata)).extensionName != nil) {
//        
//        extName = ((VdiskMetadata *)(metadata)).extensionName;
//    }
//    
//    UserEventLog(@"hot_share_file_open_success", extName);
//    
//    //	[_readerFailView setHidden:YES];
//    //	[_readerDownloadView setHidden:YES];
//    
//    //    [self alertWithHUD:@"文件下载成功"];
//    
//	if (!self.showDirectly) {
//        
//        FavoriteModel *favoriteModel = [[FavoriteModel alloc] init];
//        [favoriteModel insertMetadata:metadata];
//        [favoriteModel release];
//        [[FavoritesListViewController sharedInstance] updateFavoritesList];
//    }
//    
//    //若是当前页图片下载完成，则更新所有按钮
//    if (self.photoAlbum.centerPageIndex == [self.fileListData indexOfObject:metadata]){
//        
//        [self.photoAlbum didLoadPhoto: [self fetchBigImageByMetadata:metadata]
//                              atIndex: [self.fileListData indexOfObject:metadata]
//                            photoSize: NIPhotoScrollViewPhotoSizeOriginal];
//        
//        [self setupBarButtonsByCurrentMetaData];
//    }
//    
//}


//#pragma mark - VdiskRestClientDelegate
//
//- (void)restClient:(VdiskRestClient *)restClient copiedRef:(NSString *)copyRef to:(VdiskMetadata *)to {
//    
//    [Static clearDirCache:to.parentPath];
//    
//    [_hud hide:NO];
//    self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
//    [self.navigationController.view addSubview:_hud];
//    _hud.dimBackground = YES;
//    _hud.delegate = self;
//    
//    _hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
//    _hud.mode = MBProgressHUDModeCustomView;
//    _hud.labelText = @"保存成功";
//    [_hud show:NO];
//    [_hud hide:YES afterDelay:1.5];
//}
//
//- (void)restClient:(VdiskRestClient *)restClient copyFromRefFailedWithError:(NSError *)error {
//    
//    [self handleError:error title:@"保存失败"];
//}
//
//- (void)handleError:(NSError *)error title:(NSString *)title {
//    
//    [_hud hide:NO];
//    
//    self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
//    [self.navigationController.view addSubview:_hud];
//    _hud.dimBackground = YES;
//    _hud.delegate = self;
//    
//    _hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"X.png"]] autorelease];
//    _hud.mode = MBProgressHUDModeCustomView;
//    
//    _hud.labelText = title;
//    
//    _hud.detailsLabelText = VdiskErrorMessageWithCode(error);
//    
//    [_hud show:NO];
//    
//    [_hud hide:YES afterDelay:1.5];
//}
//
//
//- (void)restClient:(VdiskRestClient *)client calledWeiboAPI:(NSString *)apiName result:(id)result {
//    
//    if ([apiName isEqualToString:@"/statuses/update"]) {
//        
//        [_hud hide:NO];
//        self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
//        [self.navigationController.view addSubview:_hud];
//        _hud.dimBackground = YES;
//        _hud.delegate = self;
//        
//        _hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
//        _hud.mode = MBProgressHUDModeCustomView;
//        _hud.labelText = @"微博发送成功";
//        [_hud show:NO];
//        [_hud hide:YES afterDelay:1];
//        
//    }
//}
//
//- (void)restClient:(VdiskRestClient *)client callWeiboAPIFailedWithError:(NSError *)error apiName:(NSString *)apiName {
//    
//    if ([apiName isEqualToString:@"/statuses/update"]) {
//        
//        [self handleError:error title:@"发微博失败"];
//    }
//}
//
//
//- (void)restClient:(VdiskRestClient *)client copiedRef:(NSString *)copyRef accessCode:(NSString *)accessCode to:(VdiskMetadata *)to{
//    
//    [_hud hide:NO];
//    self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
//    [self.navigationController.view addSubview:_hud];
//    _hud.dimBackground = YES;
//    _hud.delegate = self;
//    _hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
//    _hud.mode = MBProgressHUDModeCustomView;
//    _hud.labelText = @"保存成功";
//    [_hud show:NO];
//    [_hud hide:YES afterDelay:1.5];
//}
//
//- (void)restClient:(VdiskRestClient *)client copyFromRefWithAccessCodeFailedWithError:(NSError *)error{
//    
//    [_hud hide:NO];
//    [self handleError:error title:@"保存失败"];
//    /* [Cloud Mario] 失败需要处理 */
//}
//
//- (void)restClient:(VdiskRestClient *)restClient copiedFromMyFriendRef:(NSString *)copyRef to:(VdiskMetadata *)to {
//    
//    [self setupBarButtonsByCurrentMetaData];
//    
//    [Static clearDirCache:to.parentPath];
//    
//    [_hud hide:NO];
//    self.hud = [[[MBProgressHUD alloc] initWithView:self.navigationController.view] autorelease];
//    [self.navigationController.view addSubview:_hud];
//    _hud.dimBackground = YES;
//    _hud.delegate = self;
//    _hud.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
//    _hud.mode = MBProgressHUDModeCustomView;
//    _hud.labelText = @"保存成功";
//    [_hud show:NO];
//    [_hud hide:YES afterDelay:1.5];
//}
//
//- (void)restClient:(VdiskRestClient *)restClient copyFromMyFriendRefFailedWithError:(NSError *)error {
//    
//    [self handleError:error title:@"保存失败"];
//}

#pragma mark - ASINetworkQueue delegate selector
- (void)requestFinished:(ASIHTTPRequest *)request
{
    //@{@"metadata": metadata, @"size":@"l"};
    NSDictionary *userInfo = request.userInfo;
    NSString *size = [userInfo objectForKey:@"size"];
    __block ImageMetadata *metadata = [userInfo objectForKey:@"metadata"];
    
    /*
     * 如果大约制定阈值，则对原图片缩小后显示
     */

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        UIImage *image = [self fetchBigImageByMetadata:metadata];

        if (!image) {
            image = [UIImage imageWithContentsOfFile:metadata.cachePath];//原图
            image.accessibilityIdentifier = [metadata.cachePath MD5EncodedString];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            /*
             * 更新下载进度
             */
            NSInteger photoIndex = [self.fileListData indexOfObject:metadata];

            for (NIPhotoScrollView *page in self.photoAlbum.visiblePages) {

                if (page.pageIndex == photoIndex) {

                    [page setLoadProgress:1];

                    break;
                }
            }


            NIPhotoScrollViewPhotoSize ps = NIPhotoScrollViewPhotoSizeThumbnail;

            if (![@"m" isEqualToString:size])
                ps = NIPhotoScrollViewPhotoSizeOriginal;

            NIPhotoScrollView *psv = (NIPhotoScrollView *)[self.photoAlbum pagingScrollView:self.photoAlbum
                                                                           pageViewForIndex:[self.fileListData indexOfObject:metadata]];

            if (psv.photoSize < ps) {

                [self.photoAlbum didLoadPhoto: image
                                      atIndex: [self.fileListData indexOfObject:metadata]
                                    photoSize: ps];
            }

            //若是当前页图片下载完成，则更新所有按钮
            if (self.photoAlbum.centerPageIndex == [self.fileListData indexOfObject:metadata])
                [self setupBarButtonsByCurrentMetaData];
        });
        
    });

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    //@{@"metadata": metadata, @"size":@"l"};
    NSDictionary *userInfo = request.userInfo;
    NSString *size = [userInfo objectForKey:@"size"];
    ImageMetadata *metadata = [userInfo objectForKey:@"metadata"];
    
    if (![@"m" isEqualToString:size]) {
        /*
         * 更新下载进度
         */
        for (NIPhotoScrollView *page in self.photoAlbum.visiblePages) {
            if (page.pageIndex == [self.fileListData indexOfObject:metadata]) {

                page.hud.progress = 1;
                [page loadProcessFailed];

                break;
            }
        }

        //若是当前页图片下载完成，则更新所有按钮
        if (self.photoAlbum.centerPageIndex == [self.fileListData indexOfObject:metadata])
            [self setupBarButtonsByCurrentMetaData];
    }
}


//- (void)queueFinished:(ASINetworkQueue *)queue
//{
//    // You could release the queue here if you wanted
////    if ([[self networkQueue] requestsCount] == 0) {
////        [self setNetworkQueue:nil];
////    }
//    NSLog(@"Queue finished");
//}

////ASIProgressDelegate
//- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
//{
//    
//    NSLog(@"====%lld======%lld",request.contentLength,bytes);
//    NSDictionary *userInfo = request.userInfo;
//    
//    NSLog(@"===----====%@",userInfo);
//}


//- (void)request:(ASIHTTPRequest *)request incrementDownloadSizeBy:(long long)newLength
//{
//    NSDictionary *userInfo = request.userInfo;
//    
//    NSLog(@"===incrementDownloadSizeBy----====%@",userInfo);
//}
//
//- (void)setProgress:(float)newProgress
//{
//    NSLog(@"===-setProgress---====%f",newProgress);
//}

@end
