//
//  MallsListViewController.h
//  MBSMapSample
//
//  Created by sunyifei on 2/13/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseOperation.h"

@class MBSRequestMalls;
@interface MallsListViewController : UIViewController <UITableViewDelegate,
UITableViewDataSource, NSXMLParserDelegate, ParseOperationDelegate>
{
    NSMutableArray *malls;
}
@property (nonatomic, retain) NSString *cityCodeUse;
@property (nonatomic, retain) MBSRequestMalls *request;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) IBOutlet UITableView *listView;

- (id)initWithNibFile;
- (id)initWithCityCode:(NSString*)cityCode;

@end
