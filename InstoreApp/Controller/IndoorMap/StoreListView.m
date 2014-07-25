//
//  StoreListView.m
//  MBSMapSample
//
//  Created by sunyifei on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StoreListView.h"
#import "MBSConnectionRequests.h"
#import "GeneralListParserOperation.h"
#import "MBSMapViewController.h"
#import "DataType.h"
#import "SingletonHelpers.h"
#import "MBSFilterInfo.h"
#import "ChineseJudge.h"
#import "MBSIconDownloader.h"
#import "CustomUITableViewCell.h"

#define logoWidth 60
#define logoHeight 33

@interface NSString (JRStringAdditions)

- (BOOL)containsString:(NSString *)string;
- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions) options;

@end

@implementation NSString (JRStringAdditions)

- (BOOL)containsString:(NSString *)string
               options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)containsString:(NSString *)string {
    return [self containsString:string options:0];
}

@end

@interface StoreListView ()
{
    int lastFilterStringCount;
    NSMutableArray *groupLabelList;
    NSMutableArray *filteredList;
}

@property (nonatomic) BOOL isFilterMode;

@end

@implementation StoreListView
@synthesize queue, mapViewController;
@synthesize isFilterMode;
@synthesize requestStores;

- (void)dealloc
{
    if (self.requestStores) {
        self.requestStores = nil;
    }
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7;
        self.userInteractionEnabled = YES;
        self.isFilterMode = NO;
        
        UISearchBar *tmpSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, 35)];
        self.searchBar = tmpSearchBar;
        [tmpSearchBar release];
        [self.searchBar setDelegate:self];
        
        UITableView *tmpListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, frame.size.height - 50) style:UITableViewStyleGrouped];
        self.listView = tmpListView;
        [tmpListView release];
        
        
        [self addSubview:self.searchBar];
        [self addSubview:self.listView];
        self.listView.allowsSelection = YES;
        self.listView.allowsSelectionDuringEditing = YES;

        filteredList = [[NSMutableArray alloc] init];
        self.imageDownloads = [NSMutableDictionary dictionary];
        self.mapViewController = nil;
        
        lastFilterStringCount = 0;
    }
    return self;
}

- (void)loadViewWithCityCode:(NSString*)cityCode withMallId:(NSInteger)mallId
{
    MBSRequestStores *request = [[MBSRequestStores alloc] initWithDelegate:self action:@selector(receiveDataViaInternet:withObject:) withCityCode:cityCode withMallId:mallId sortedByName:YES];
    [request connect];
    
    self.requestStores = request;
    [request release];
    self.listView.dataSource = self;
    [self.listView setDelegate:self];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSLog(@"searchBar: textDidChange !!! text = %@", self.searchBar.text);
    
    if ((!groupLabelList) || ([groupLabelList count] <= 0)) {
        self.isFilterMode = NO;
        return;
    }
    
    NSString *strFilterText = self.searchBar.text;
    int textLength = [strFilterText length];
    if (textLength > 0) {
        self.isFilterMode = YES;
        MBSFilterInfo *filterInfo = [[MBSFilterInfo alloc] init];
        filterInfo.filterString = strFilterText;
        
        if (textLength > lastFilterStringCount) {
            filterInfo.fIsFurtherFilter = YES;
        } else {
            filterInfo.fIsFurtherFilter = NO;
        }
        [self updateListViewBaseOnFilter:filterInfo];
        lastFilterStringCount = textLength;
        [filterInfo release];
    } else {
        self.isFilterMode = NO;
        [self.listView reloadData];
    }
}

#pragma mark - table view
-(void)updateListViewBaseOnFilter:(MBSFilterInfo *) filterInfo {
    
    BOOL fAddFromFullList = YES;
    if(([filteredList count] > 0) && (filterInfo.fIsFurtherFilter)) {
        fAddFromFullList = NO;
    }
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:4];
    BOOL filterHasChinese = [ChineseJudge stringHasChinese:filterInfo.filterString andConvertTo:resultString];    
    if (fAddFromFullList) {
        [filteredList removeAllObjects];
        
        for (int j = 0; j < [groupLabelList count]; j++) {
            StoreGroupLabel *groupLabel = [groupLabelList objectAtIndex:j];
            
            NSMutableArray *selectedStoreInfoList = groupLabel.subItems;
            NSMutableString *resultLabel = [NSMutableString stringWithCapacity:4];
            for (int i = 0; i < [selectedStoreInfoList count]; i++) {
                StoreInfo *storeInfo = [selectedStoreInfoList objectAtIndex:i];

                [resultLabel setString:@""];

                //如果用户输入的字符串有中文，则直接比较；否则要把每个店铺名转化为中文首字母比较
                if (filterHasChinese) {
                    [ChineseJudge stringHasChinese:storeInfo.brandName andConvertTo:resultLabel];
                    if ([storeInfo.brandName containsString:filterInfo.filterString]) {
                        [filteredList addObject:storeInfo];
                    }
                } else {
                    [ChineseJudge stringHasChinese:storeInfo.brandName andConvertTo:resultLabel];
                    if ([resultLabel containsString:filterInfo.filterString options:NSCaseInsensitiveSearch]) {
                        [filteredList addObject:storeInfo];
                    }
                }
            }
        }
    } else {
        NSMutableString *resultLabel = [NSMutableString stringWithCapacity:4];
        int count = [filteredList count];
        for (int i = count-1; i >= 0; --i) {
            StoreInfo *storeInfo = [filteredList objectAtIndex:i];
            
            [resultLabel setString:@""];
            
            //如果用户输入的字符串有中文，则直接比较；否则要把每个店铺名转化为中文首字母比较
            if (filterHasChinese) {
                [ChineseJudge stringHasChinese:storeInfo.brandName andConvertTo:resultLabel];
                if (![storeInfo.brandName containsString:filterInfo.filterString]) {
                    [filteredList removeObject:storeInfo];
                }
            } else {
                [ChineseJudge stringHasChinese:storeInfo.brandName andConvertTo:resultLabel];
                if (![resultLabel containsString:filterInfo.filterString options:NSCaseInsensitiveSearch]) {
                    [filteredList removeObject:storeInfo];
                }
            }
        }
    }
    
    [self.listView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (groupLabelList) {
        if (self.isFilterMode) {
            return [filteredList count];
        } else {
            return [groupLabelList count];
        }
    } else {
        return 0;
    }
}

-(NSInteger) tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if (groupLabelList){
        if (self.isFilterMode) {
            int result = (section == 0) ? [filteredList count]:0;
            return result;
        } else {
            StoreGroupLabel *groupLabel = [groupLabelList objectAtIndex:section];
            return [groupLabel.subItems count];
        }
    } else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *strTitle = nil;
    if ((groupLabelList) && (!self.isFilterMode)) {
        StoreGroupLabel *groupLabel = [groupLabelList objectAtIndex:section];
        strTitle = [NSString stringWithFormat:@"%c", groupLabel.label];
    }
    
    return strTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* CellIdentifier = @"Cell";
    
    NSInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    CustomUITableViewCell* cell = [self.listView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil ) 
    {
        cell = [[[CustomUITableViewCell alloc]
                 initWithStyle: UITableViewCellStyleSubtitle
                 reuseIdentifier: CellIdentifier] autorelease];
    }
    
    if (groupLabelList) {
        StoreListItem *store;
        if (self.isFilterMode) {
            store = [filteredList objectAtIndex:row];
        } else {
            StoreGroupLabel *groupLabel = [groupLabelList objectAtIndex:section];
            store = [groupLabel.subItems objectAtIndex:row];
        }
        
        if (store.brandLogoUrl == nil) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"defaulticon" ofType:@"png"];
            ((CustomUITableViewCell *)cell).imageView.image = [UIImage imageWithContentsOfFile:path];
        }else{
            UIImage *iconObj = [self tryToGetImageFromCache:store.brandLogoUrl];
            if (iconObj) {
                ((CustomUITableViewCell *)cell).imageView.image = iconObj;
            }else{
                if ([self startIconDownload:store.brandLogoUrl forIndexPath:indexPath]) {
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"defaulticon" ofType:@"png"];
                    cell.imageView.image = [UIImage imageWithContentsOfFile:path];
                }else{
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"defaulticon" ofType:@"png"];
                    cell.imageView.image = [UIImage imageWithContentsOfFile:path];
                }
            }
        }
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.text = store.brandName;
        cell.detailTextLabel.text = store.displayedFloorMarker;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setHidden:YES];
    
    if (groupLabelList) {
        StoreGroupLabel *groupLabel = [groupLabelList objectAtIndex:[indexPath section]];
        
        StoreListItem *store = [groupLabel.subItems objectAtIndex:[indexPath row]];
        [mapViewController selectStoreWithFloorId:store.floorId storeId:store.storeId];
    }
}

#pragma mark - IconDownloaderDelegate
- (BOOL)startIconDownload:(NSString *)iconUrl forIndexPath:(NSIndexPath *)indexPath
{
    BOOL bRet = YES;
    NSMutableDictionary *dic = self.imageDownloads;
    
    MBSIconDownloader *iconDownloader = [dic objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[MBSIconDownloader alloc] init];
        iconDownloader.imageUrl = iconUrl;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [dic setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];
    }else{
        if (iconDownloader.status == DOWNLOAD_FAIL) {
            bRet = NO;
        }
    }
    return bRet;
}

-(void)iconLoadFail:(NSIndexPath *)indexPath
{
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)iconDidLoad:(NSIndexPath *)indexPath downloadedIcon:(UIImage *)iconObj
{
    StoreListItem *store = nil;
    if (self.isFilterMode){
        store = [filteredList objectAtIndex:[indexPath row]];
    
    } else {
        StoreGroupLabel *groupLabel = [groupLabelList objectAtIndex:[indexPath section]];
        store = [groupLabel.subItems objectAtIndex:[indexPath row]];
    }
    
    NSString *key = [NSString stringWithFormat:@"%lld", store.storeId];
    MBSIconDownloader *iconDownloader = [self.imageDownloads objectForKey:key];
    if (iconDownloader != nil)
    {
        CustomUITableViewCell *cell = (CustomUITableViewCell *)[self tableView:self.listView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        if (cell != Nil) {
            cell.imageView.image = iconObj;
        }
    }
}

- (UIImage *)tryToGetImageFromCache: (NSString *)imageUrl
{
    UIImage *iconObj = nil;
    if([[SingletonHelpers shareIconDownloader] loadImageFromCache:imageUrl])
    {
        iconObj = [[SingletonHelpers shareIconDownloader] loadImageFromCache:imageUrl];
    }
    return iconObj;
}

#pragma mark -- connection functions
-(void)receiveDataViaInternet:(id)sender withObject:(id)responseData
{
    if (responseData) {
        self.queue = [NSOperationQueue currentQueue];
        NSData *receivedData = (NSData *)responseData;
        if ([receivedData length] > 0) {
            
            NSLog(@"get malls list !!! set DATA_TYPE_STORELIST2 !!!");
            ParseOperation *parser = [[GeneralListParserOperation alloc] initWithData:receivedData DataType:DATA_TYPE_STORELIST2 delegate:self];
            [self.queue addOperation:parser];
            
            [parser release];
        }
    } else {
        NSLog(@"get malls list fail !!!");
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
    groupLabelList = [[NSMutableArray arrayWithArray:parsedData] retain];
    [self.listView reloadData];
}
@end
