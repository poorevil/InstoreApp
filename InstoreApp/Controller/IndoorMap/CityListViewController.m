//
//  CityListViewController.m
//  MBSMapSample
//
//  Created by sunyifei on 2/13/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import "CityListViewController.h"
#import "MBSConnectionRequests.h"
#import "GeneralListParserOperation.h"
#import "MallsListViewController.h"
#import "DataType.h"

@implementation CityListViewController
@synthesize listView, queue;


-(id)initWithNibFile
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self = [self initWithNibName:@"CityListViewController-iPad" bundle:nil];
    }
    else
    {
        self = [self initWithNibName:@"CityListViewController" bundle:nil];
    }
    cityInfos = [[NSMutableArray array] retain];
    
    return self;
}

- (void)viewDidLoad
{
    self.title = @"城市列表";
    MBSRequestCitys *request = [[MBSRequestCitys alloc] initWithDelegate:self action:@selector(receiveDataViaInternet:withObject:)]; //获取城市列表
    [request connect];
    
    self.requestCitys = request;
    [request release];
    self.listView.dataSource = self;
    self.listView.delegate = self;
}

-(void)dealloc
{
    if (self.requestCitys) {
        [self.requestCitys cancel];
        self.requestCitys = nil;
    }
    [super dealloc];
}

#pragma mark - table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* CellIdentifier = @"Cell";
    
    NSUInteger row = [indexPath row];
    
    UITableViewCell* cell = [self.listView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil ) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
        UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width - 80, cell.frame.origin.y, 80, cell.frame.size.height)];
        cell.accessoryView = labelView;
        [labelView release];
    }
    
    CityInfo *cityInfo = [cityInfos objectAtIndex:row];
    cell.textLabel.text = cityInfo.cityName;
    UILabel *accessoryLabel = (UILabel *)cell.accessoryView;
    accessoryLabel.text = cityInfo.cityCode;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.listView cellForRowAtIndexPath:indexPath];
    
    UIViewController *targetViewController = [[MallsListViewController alloc] initWithCityCode:((UILabel *)cell.accessoryView).text];
                                              
    [self.navigationController pushViewController:targetViewController animated:YES];
    [targetViewController release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cityInfos count];
}

- (void)didFinishParsing:(NSArray *)parsedData
{
    [self performSelectorOnMainThread:@selector(handleLoadedParsedData:)
                           withObject:parsedData
                        waitUntilDone:NO];
}

- (void)parseErrorOccurred:(NSError *)error
{
}

- (void)handleLoadedParsedData:(NSArray *)parsedData
{
    cityInfos = [[NSMutableArray arrayWithArray:parsedData] retain];
    [self.listView reloadData];
}

#pragma mark -- connection functions
-(void)receiveDataViaInternet:(id)sender withObject:(id)responseData
{
    if (responseData) {
        self.queue = [NSOperationQueue currentQueue];
        NSData *receivedData = (NSData *)responseData;
        if ([receivedData length] > 0) {
            ParseOperation *parser = [[GeneralListParserOperation alloc] initWithData:receivedData DataType:DATA_TYPE_CITY delegate:self];
            [self.queue addOperation:parser];
            
            [parser release];
        }
    }
}

@end
