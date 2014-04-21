//
//  StoreListView.h
//  MBSMapSample
//
//  Created by sunyifei on 2/13/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseOperation.h"
#import "MBSIconDownloaderDelegate.h"

@interface FloorInfoViewController : UIViewController <UITableViewDelegate,
UITableViewDataSource, ParseOperationDelegate>
{
    NSMutableArray *floorList;
}

@property (nonatomic, retain) IBOutlet UITableView *listView;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic) int mallId;
@property (nonatomic, retain) NSString *cityCodeUse;
@property (nonatomic, retain) NSString *mallName;

- (id)initWithNibFile;
- (id)initWithCityCode:(NSString *)cityCode withMallId:(int)theMallId withMallName:(NSString *)theMallName;

@end
