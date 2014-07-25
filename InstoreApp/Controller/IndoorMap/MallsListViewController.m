//
//  MallsListViewController.m
//  MBSMapSample
//
//  Created by sunyifei on 2/13/12.
//  Copyright (c) 2012 __www.widitu.net__. All rights reserved.
//

#import "MallsListViewController.h"
#import "MBSConnectionRequests.h"
#import "GeneralListParserOperation.h"
#import "DataType.h"
#import "FloorInfoViewController.h"

@implementation MallsListViewController
@synthesize listView;
@synthesize request;
@synthesize cityCodeUse;

-(id)initWithNibFile
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self = [self initWithNibName:@"ListViewController-iPad" bundle:nil];
    }
    else
    {
        self = [self initWithNibName:@"ListViewController" bundle:nil];
    }
    malls = [[NSMutableArray array] retain];
    self.cityCodeUse = @"010";
    return self;
}

-(id)initWithCityCode:(NSString*)cityCode
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self = [self initWithNibName:@"ListViewController-iPad" bundle:nil];
    }
    else
    {
        self = [self initWithNibName:@"ListViewController" bundle:nil];
    }
    malls = [[NSMutableArray array] retain];
    self.cityCodeUse = cityCode;
    return self;
}

- (void)viewDidLoad
{
    MBSRequestMalls *requestTemp = [[MBSRequestMalls alloc] initWithDelegate:self action:@selector(receiveDataViaInternet:withObject:) withCityCode:self.cityCodeUse];
    [requestTemp connect];
    
    self.request = requestTemp;
    [requestTemp release];
    
    self.listView.dataSource = self;
    self.listView.delegate = self;
}

-(void)dealloc
{
    if (self.request) {
        [self.request cancel];
        self.request = nil;
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
    Mall *mall = [malls objectAtIndex:row];
    cell.textLabel.text = mall.mallName;
    UILabel *accessoryLabel = (UILabel *)cell.accessoryView;
    accessoryLabel.text = [NSString stringWithFormat:@"%d", mall.mallId];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [malls count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [self.listView cellForRowAtIndexPath:indexPath];
    
    UIViewController *targetViewController = [[FloorInfoViewController alloc] initWithCityCode:self.cityCodeUse withMallId:[((UILabel *)cell.accessoryView).text intValue] withMallName:cell.textLabel.text];
    
    [self.navigationController pushViewController:targetViewController animated:YES];
    [targetViewController release];
}

- (void)didFinishParsing:(NSArray *)parsedData
{
    [self performSelectorOnMainThread:@selector(handleLoadedParsedData:)
                           withObject:parsedData
                        waitUntilDone:NO];
}

- (void)handleLoadedParsedData:(NSArray *)parsedData
{
    malls = [[NSMutableArray arrayWithArray:parsedData] retain];
    [self.listView reloadData];
}

#pragma mark -- connection functions
-(void)didFinishParsing
{
    
}

-(void)receiveDataViaInternet:(id)sender withObject:(id)responseData
{
    if (responseData) {
        self.queue = [NSOperationQueue currentQueue];
        NSData *receivedData = (NSData *)responseData;
        if ([receivedData length] > 0) {
            ParseOperation *parser = [[GeneralListParserOperation alloc] initWithData:receivedData DataType:DATA_TYPE_MALL delegate:self];
            [self.queue addOperation:parser];
            
            [parser release];
        }
    }
}
- (void)parseErrorOccurred:(NSError *)error{
    
}

@end
