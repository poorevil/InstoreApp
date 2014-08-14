//
//  StoreListView.m
//  MBSMapSample
//
//  Created by sunyifei on 2/13/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import "FloorInfoViewController.h"
#import "MBSConnectionRequests.h"
#import "MBSFloorParserOperation.h"
#import "DataType.h"
#import "SingletonHelpers.h"
#import "MBSFloor.h"
#import "IndoorMapViewController.h"
#import "MBSIconDownloader.h"

#define logoWidth 60
#define logoHeight 33


@implementation FloorInfoViewController
@synthesize listView, queue, mallId, mallName, cityCodeUse;

-(id)initWithNibFile
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self = [self initWithNibName:@"FloorInfoViewController-iPad" bundle:nil];
    }
    else
    {
        self = [self initWithNibName:@"FloorInfoViewController" bundle:nil];
    }
    floorList = nil;//[[NSMutableArray array] retain];
    
    self.mallId = 118;
    self.mallName = @"西单大悦城";
    self.cityCodeUse = @"010";
    
    return self;
}

-(id)initWithCityCode:(NSString *)cityCode withMallId:(int)theMallId withMallName:(NSString *)theMallName
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self = [self initWithNibName:@"FloorInfoViewController-iPad" bundle:nil];
    }
    else
    {
        self = [self initWithNibName:@"FloorInfoViewController" bundle:nil];
    }
    floorList = nil;//[[NSMutableArray array] retain];
    
    self.mallId = theMallId;
    self.mallName = theMallName;
    self.cityCodeUse = cityCode;
    
    return self;
}

- (void)viewDidLoad
{
    MBSRequestFloors *requestFloors = [[MBSRequestFloors alloc] initWithDelegate:self action:@selector(receiveDataViaInternet:withObject:) withMallId:self.mallId withImages:NO];
    [requestFloors connect];
    
    self.listView.dataSource = self;
    self.listView.delegate = self;
}

#pragma mark - table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!floorList) {
        return Nil;
    }
    
    NSString* CellIdentifier = @"Cell";
    
    NSUInteger row = [indexPath row];
//    NSLog(@"row = %d", row);
    
    UITableViewCell* cell = [self.listView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil ) 
    {
        cell = [[[UITableViewCell alloc]
                 initWithStyle: UITableViewCellStyleSubtitle
                 reuseIdentifier: CellIdentifier] autorelease];
    }
    
    MBSFloorURL *floor = [floorList objectAtIndex:row];
    
    cell.textLabel.text = floor.floorID;
    cell.detailTextLabel.text = floor.brief;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.listView cellForRowAtIndexPath:indexPath];
    UIViewController *targetViewController = [[IndoorMapViewController alloc] initWithFrame:self.view.frame withFloorId:(NSString *)cell.textLabel.text withMallId:self.mallId withCityCode:self.cityCodeUse withMallName:self.mallName];
    [self.navigationController pushViewController:targetViewController animated:YES];
    [targetViewController release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (floorList) {
        return [floorList count];
    } else {
        return 0;
    }
}

#pragma mark -- connection functions
-(void)receiveDataViaInternet:(id)sender withObject:(id)responseData
{
    if (responseData) {
        NSData *receivedData = (NSData *)responseData;
        if ([receivedData length] > 0) {
            queue = [NSOperationQueue currentQueue];
            
            MBSFloorParserOperation *parser = [[MBSFloorParserOperation alloc] initWithData:responseData DataType:DATA_TYPE_SVG_SPACE delegate:self];
            
            [queue addOperation:parser]; // this will start the "ParseOperation"
            
            [parser release];
        }
    } else {
        DebugLog(@"get svg space fail !!!");
    }
}


- (void)parseErrorOccurred:(NSError *)error {
    
}

- (void)didFinishParsing:(NSArray *)parsedData
{
    [self performSelectorOnMainThread:@selector(handleLoadedParsedData:)
                           withObject:parsedData
                        waitUntilDone:NO];
}

- (void)handleLoadedParsedData:(NSArray *)parsedData
{
    floorList = [[NSMutableArray arrayWithArray:parsedData] retain];
    
    //Parsing complete, reload data.
//    bLoadDataFinished = YES;
    [self.listView reloadData];
//    self.queue = nil;
}
@end
