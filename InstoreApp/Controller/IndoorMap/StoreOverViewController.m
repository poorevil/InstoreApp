//
//  StoreOverViewController.m
//  SmartMall
//
//  Created by dujianping on 8/28/11.
//  update by sunyifei 11/02/2012
//  Copyright 2012 __Mobistone__. All rights reserved.
//

#import "StoreOverViewController.h"
#import "MBSErrorCorrection.h"
#import "DataType.h"
#import "MBSConnectionRequests.h"
#import "GeneralListParserOperation.h"
#import "MBSIconDownloader.h"
#import "BaseDataType.h"

//define for table view
#define LISTVIEW_ITEM_COUNT      5
#define LISTVIEW_CELL0_HEIGHT    200.0f//86

//define the max label width
#define MAX_LABEL_WIDTH          150

//define the toolbar button tag base
#define TOOLBAR_BTN_TAG_BASE     100

#define ALERT_BTN_CONFIRM         @"确认"
#define ALERT_BTN_CLOSE           @"关闭"
#define ACTIONSHEET_ERROR_STORE_TEL        @"商户电话错误"
#define ACTIONSHEET_ERROR_STORE_CLOSED     @"商户已关闭"
#define ACTIONSHEET_ERROR_STORE_NAME       @"商户名称错误"
#define ACTIONSHEET_ERROR_STORE_LOGO       @"商户LOGO错误"
#define ACTIONSHEET_CANCEL                 @"取消"
@interface StoreOverViewController ()

@property (nonatomic, retain) MBSErrorCorrection *errorReporter;

@end

@implementation StoreOverViewController

@synthesize storeId, currentStoreInfo, cityCodeUse;
@synthesize errorReporter, iconDownloader, iconView;
@synthesize listView;
@synthesize requestStoreDetail;

-(id)initWithNibFile
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self = [self initWithNibName:@"ListViewController-iPad" bundle:nil];
    }
    else
    {
        self = [self initWithNibName:@"ListViewController" bundle:nil];
    }
    
    return self;
}

- (void)dealloc
{
    self.iconDownloader = nil;
    self.iconView = nil;
    self.listView = nil;
    self.errorReporter = nil;
    self.cityCodeUse = nil;
    self.currentStoreInfo = nil;
    
    if (self.requestStoreDetail) {
        [self.requestStoreDetail cancel];
        self.requestStoreDetail = nil;
    }
    if (self.queue) {
        [self.queue cancelAllOperations];
        self.queue = nil;
    }
    [super dealloc];
}

-(void)createRightBarItem:(NSString *)title tagert:(id)target action:(SEL)action
{
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    rightBtn.backgroundColor = [UIColor lightGrayColor];
    rightBtn.imageView.contentMode = UIViewContentModeCenter;
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    [rightBarBtnItem release];
    [rightBtn release];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [self createRightBarItem:@"信息纠错" tagert:self action:@selector(launchErrorCorrectionSheet)];
    MBSRequestStoreDetail *request = [[MBSRequestStoreDetail alloc] initWithDelegate:self action:@selector(receiveDataViaInternet:withObject:) withStoreId:storeId withCityCode:cityCodeUse withCache:NO];
    
    self.requestStoreDetail = request;
    [request release];
    [self.requestStoreDetail connect];
    
    self.listView.dataSource = self;
    self.iconDownloader = nil;
    self.iconView = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - connection functions
-(void)receiveDataViaInternet:(id)sender withObject:(id)responseData
{
    if (responseData) {
        self.queue = [NSOperationQueue currentQueue];
        NSData *receivedData = (NSData *)responseData;
        if ([receivedData length] > 0) {
            ParseOperation *parser = [[GeneralListParserOperation alloc] initWithData:receivedData DataType:DATA_TYPE_STORE_OVERVIEW delegate:self];
            [self.queue addOperation:parser];
            
            [parser release];
        }
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
    self.currentStoreInfo = [[NSMutableArray arrayWithArray:parsedData] objectAtIndex:0];
    [self.listView reloadData];
}

#pragma mark - iconDownloader
- (UIImage *)tryToGetImageFromCache: (NSString *)imageUrl
{
    if (!self.iconDownloader) {
        return nil;
    } else {
        return [self.iconDownloader loadImageFromCache:imageUrl];
    }
}

- (BOOL)startIconDownload:(NSString *)iconUrl forIndexPath:(NSIndexPath *)indexPath
{
    BOOL bRet = YES;
    
    if (!self.iconDownloader) {
        MBSIconDownloader *tempIconDownloader = [[MBSIconDownloader alloc] init];
        self.iconDownloader = tempIconDownloader;
        [tempIconDownloader release];
    }
    
    self.iconDownloader.imageUrl = iconUrl;
    self.iconDownloader.indexPathInTableView = indexPath;
    self.iconDownloader.delegate = self;
    [self.iconDownloader startDownload];
    
    return bRet;
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)iconDidLoad:(NSIndexPath *)indexPath downloadedIcon:(UIImage *)iconObj
{
    if (self.iconView) {
        [self.listView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:(UITableViewRowAnimationFade)];
    }
}

-(void)iconLoadFail:(NSIndexPath *)indexPath
{
    currentStoreInfo.brandLogoUrl = nil;
    [self.listView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:(UITableViewRowAnimationFade)];
}

#pragma mark - table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* CellIdentifier = @"Cell";
    
    NSUInteger row = [indexPath row];
    
    UITableViewCell* cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
    
    switch (row) {
        case 0:
        {
            self.iconView = cell.imageView;
            if ((currentStoreInfo.brandLogoUrl == nil) || (currentStoreInfo.brandLogoUrl.length <= 0)) {
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"defaulticon" ofType:@"png"];
                    self.iconView.image = [UIImage imageWithContentsOfFile:path];
                }else{
                    UIImage *iconObj = [self tryToGetImageFromCache:currentStoreInfo.brandLogoUrl];
                    if (iconObj) {
                        self.iconView.image = iconObj;
                    }else{
                        [self startIconDownload:currentStoreInfo.brandLogoUrl forIndexPath:indexPath];
                        NSString *path = [[NSBundle mainBundle] pathForResource:@"defaulticon" ofType:@"png"];
                        self.iconView.image = [UIImage imageWithContentsOfFile:path];
                    }
            }

            cell.textLabel.text = currentStoreInfo.brandName;
        }
            break;
        case 1:
        {
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.textLabel.text = [NSString stringWithFormat:@"店铺位置：%@", currentStoreInfo.storePos];
        }
            break;
            case 2:
        {
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.textLabel.text = [NSString stringWithFormat:@"联系电话：%@", currentStoreInfo.storeTel];
        }
            break;
            case 3:
        {
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.textLabel.text = [NSString stringWithFormat:@"商场地址：%@", currentStoreInfo.mallAddr];
        }
            break;
            case 4:
        {
            cell.textLabel.font = [UIFont systemFontOfSize:18];
            cell.textLabel.text = [NSString stringWithFormat:@"店铺介绍：%@", currentStoreInfo.brandDesc];
        }
            break;
        default:
            break;
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return LISTVIEW_ITEM_COUNT;
}

#pragma mark - error correction

-(void)launchErrorCorrectionSheet
{
    UIActionSheet *errorCorrectionSheet = [[UIActionSheet alloc] initWithTitle:@"信息报错" delegate:self cancelButtonTitle:ACTIONSHEET_CANCEL destructiveButtonTitle:nil otherButtonTitles:ACTIONSHEET_ERROR_STORE_CLOSED, ACTIONSHEET_ERROR_STORE_NAME, ACTIONSHEET_ERROR_STORE_TEL, ACTIONSHEET_ERROR_STORE_LOGO, nil];
    [errorCorrectionSheet showInView:self.view];
    [errorCorrectionSheet release];
}

#pragma mark - Action Sheet Delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if (![buttonTitle isEqualToString:ACTIONSHEET_CANCEL]) {
        if (self.errorReporter == nil) {
            MBSErrorCorrection *errorReportView = [[MBSErrorCorrection alloc] init];
            self.errorReporter = errorReportView;
            [errorReportView release];
        }
        NSInteger type = 0;
        NSString *placeHolder = nil;
        BOOL bIncludeTextInput = YES;
        if ([buttonTitle isEqualToString:ACTIONSHEET_ERROR_STORE_CLOSED]) {
            type = ERROR_STORE_CLOSE;
            bIncludeTextInput = NO;
        }
        else if ([buttonTitle isEqualToString:ACTIONSHEET_ERROR_STORE_NAME]){
            type = ERROR_STORE_NAME;
            placeHolder = @"请输入正确的商户名称";
        }
        else if ([buttonTitle isEqualToString:ACTIONSHEET_ERROR_STORE_TEL]){
            type = ERROR_STORE_PHONE;
            placeHolder = @"请输入正确的商户电话";
        }else if ([buttonTitle isEqualToString:ACTIONSHEET_ERROR_STORE_LOGO]) {
            type = ERROR_STORE_LOGO;
            bIncludeTextInput = FALSE;
        }
        [self.errorReporter showErrorCorrectionAlertWithTextField:type
                                                     withObjectId:storeId
                                                    withTextField:bIncludeTextInput
                                                  withPlaceHolder:placeHolder];
    }
}


@end
