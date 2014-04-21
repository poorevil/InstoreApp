//
//  StoreListView.h
//  MBSMapSample
//
//  Created by sunyifei on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseOperation.h"
#import "MBSIconDownloaderDelegate.h"

@class MBSMapViewController, MBSRequestStores;
@interface StoreListView : UIView <UITableViewDelegate,
UITableViewDataSource, ParseOperationDelegate, MBSIconDownloaderDelegate, UISearchBarDelegate>

@property (nonatomic, retain) MBSRequestStores *requestStores;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *listView;
@property (nonatomic, assign) MBSMapViewController *mapViewController;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSMutableDictionary *imageDownloads;

- (id)initWithFrame:(CGRect)frame;
- (void)loadViewWithCityCode:(NSString*)cityCode withMallId:(NSInteger)mallId;

@end
