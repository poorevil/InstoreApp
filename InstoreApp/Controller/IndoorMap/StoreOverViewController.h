//
//  StoreOverViewController.h
//  SmartMall
//
//  Created by dujianping on 8/28/11.
//  update by sunyifei 11/02/2012
//  Copyright 2012 __Mobistone__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseOperation.h"
#import "MBSIconDownloaderDelegate.h"

@class StoreInfo, MBSIconDownloader, MBSRequestStoreDetail;
@interface StoreOverViewController : UIViewController<UIActionSheetDelegate, ParseOperationDelegate, UITableViewDelegate, UITableViewDataSource, MBSIconDownloaderDelegate>{
    BOOL bHandlingFocus;
}
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) MBSIconDownloader *iconDownloader;

@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) UIImageView *iconView;

@property (nonatomic, retain) NSString *cityCodeUse;
@property (nonatomic, assign) long long storeId;
@property (nonatomic, retain) StoreInfo* currentStoreInfo;

@property (nonatomic, retain) MBSRequestStoreDetail *requestStoreDetail;

-(id)initWithNibFile;

@end
