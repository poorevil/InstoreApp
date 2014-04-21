//
//  CityListViewController.h
//  MBSMapSample
//
//  Created by sunyifei on 2/13/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseOperation.h"

@class MBSRequestCitys;
@interface CityListViewController : UIViewController <UITableViewDelegate,
UITableViewDataSource, ParseOperationDelegate>
{
    NSMutableArray *cityInfos;
}

@property (nonatomic, retain) MBSRequestCitys *requestCitys;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) IBOutlet UITableView *listView;

- (id)initWithNibFile;
- (void)didFinishParsing:(NSArray *)parsedData;

@end
