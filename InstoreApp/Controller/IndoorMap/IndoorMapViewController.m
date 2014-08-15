//
//  IndoorMapViewController.m
//  MBSMap
//
//  Created by sunyifei on 9/19/11.
//  Copyright 2011 __www.widitu.net__. All rights reserved.
//

#import "IndoorMapViewController.h"
#import "Constants.h"
#import "SVProgressHUD.h"
#import "StoreOverViewController.h"
#import "UIGlossyButton.h"
//#import "MallStoresViewController.h"
#import "MBSMapKit.h"
#import "StoreListView.h"


@implementation IndoorMapViewController
@synthesize mFloorSwitcher, storeListView, cityCodeUse;
@synthesize zoomInBtn, zoomOutBtn;
@synthesize firstFloorId, mallId;

- (id)initWithFrame:(CGRect)frame
{
	if (!(self = [super init]))
        return nil;
    
    self.storeListView = nil;
    self.cityCodeUse = @"022";
    self.firstFloorId = nil;
    self.mallId = 1350;//天津银河，galaxy
    mSelectedFloorIndex = 0;
    self.view.frame = frame;
    self.title = @"GALAXY";
    
	return self;
}

- (id)initWithFrame:(CGRect)frame withFloorId:(NSString *)strFloorId withMallId:(NSInteger)tempMallId withCityCode:(NSString *)cityCode withMallName:(NSString *)mallName
{
	if (!(self = [super init])) {
        return nil;
    }
    self.title = mallName;
    self.storeListView = nil;
    self.cityCodeUse = cityCode;
    self.firstFloorId = strFloorId;
    self.mallId = tempMallId;
    mSelectedFloorIndex = 0;
    self.view.frame = frame;
	return self;
}

//called when navback
- (void)dealloc
{
    MBSPopup *popup = [MBSPopup getInstance];
    if (popup) {
        [popup setDelegate:nil];
        [popup setPopUpView:nil];
    }
    
    if (self.mMapControl) {
        self.mMapControl = nil;
    }
    
    if (self.mFloorSwitcher) {
        self.mFloorSwitcher = nil;
    }
    [super dealloc];
}

//called when in low memory
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidLoad
{
//    [self createRightBarItem:@"店铺列表" tagert:self action:@selector(switchToStoreListView)];
    [self createRightBarItem:@"楼层选择" tagert:self action:@selector(showListTableView)];
    
    float navgationBarHeight = 44; //self.navigationController.navigationBar.frame.size.height
    CGRect mallMapRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - navgationBarHeight);
    
    
    if (self.firstFloorId) {
        MBSMall *currentMall = [MBSMall getCurrentMall];
        [currentMall setFirstFloorId:self.firstFloorId];
    }
    
    MBSMapViewController *mapController = [[MBSMapViewController alloc] initWithFrame:mallMapRect withMallId:self.mallId withDelegate:self];
    self.mMapControl = mapController;
    [mapController release];
    
    [self.view addSubview:self.mMapControl.view];
    [self createZoomButtons];
    
}

- (void)switchToStoreListView {
    //    MallStoresViewController *mallStoresViewController = [[MallStoresViewController alloc] initWithCity:self.cityCodeUse withMall:self.mallId withMapViewController:self.mMapControl];
    //
    //    [self.navigationController pushViewController:mallStoresViewController animated:YES];
    //    [mallStoresViewController release];
    
    
    if (storeListView == nil) {
        storeListView = [[StoreListView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 30, self.view.frame.origin.y + 30, self.view.frame.size.width - 60, self.view.frame.size.height - 60)];
        
        [self.view addSubview:storeListView];
        [storeListView loadViewWithCityCode:@"010" withMallId:self.mallId];
        [self.storeListView setMapViewController: self.mMapControl];
    } else if(storeListView.isHidden) {
        [storeListView setHidden:NO];
    } else {
        [storeListView setHidden:YES];
    }
    
}

- (IBAction)addAction:(id)sender
{
}

-(void)createRightBarItem:(NSString *)title tagert:(id)target action:(SEL)action
{
//    UIGlossyButton *rightBtn = [[UIGlossyButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 30);
//	[rightBtn setNavigationButtonWithColor:[UIColor navigationBarButtonColor]];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    [rightBarBtnItem release];
//    [rightBtn release];
}

-(void)showListTableView{
    if (self.mFloorSwitcher.frame.origin.y > 0) {
        return;
    }
    
    [UIView animateWithDuration:0.6 animations:^(void){
        CGRect frame = self.mFloorSwitcher.frame;
        frame.origin.y += self.view.frame.size.height - 64;
        self.mFloorSwitcher.frame = frame;
    }];
}
-(void)hiddenListTableView{
    [UIView animateWithDuration:0.6 animations:^(void){
        CGRect frame = self.mFloorSwitcher.frame;
        frame.origin.y -= self.view.frame.size.height - 64;
        self.mFloorSwitcher.frame = frame;
    }];
}

#pragma mark - table delegate - floorSwitcher
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* CellIdentifier = @"Floor";
    
    NSUInteger row = [indexPath row];
    
    UITableViewCell* cell = [self.mFloorSwitcher dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
        cell.textLabel.font = [UIFont systemFontOfSize:10];
    }
    
    
    NSString *floorId = [floorInforArray objectAtIndex:row];
    MBSMall *currentMall = [MBSMall getCurrentMall];
    MBSFloor *floor = [currentMall.floorDict objectForKey:floorId];
    
    NSString *floorName = [NSString stringWithFormat:@"%@", [floor name]];
    
    cell.textLabel.text = floorName;
    cell.textLabel.opaque = YES;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int totalFloor = 0;
    MBSMall *currentMall = [MBSMall getCurrentMall];
    if((currentMall) && (currentMall.floorDict)) {
        totalFloor = [currentMall.floorDict count];
    }
    return totalFloor;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.mMapControl switchFloor: [floorInforArray objectAtIndex:indexPath.row]];
    [self hiddenListTableView];
}


#pragma mark - MBSMapViewControllerDelegate
-(void)createFloorSwitchControl:(UIView *)mapView {
    self.mFloorSwitcher = [[[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40, 64 -(self.view.frame.size.height - 64), 40, self.view.frame.size.height-64)  style:UITableViewStylePlain]autorelease];
    
    MBSMall *currentMall = [MBSMall getCurrentMall];
    
    [floorInforArray release];
    floorInforArray = [[currentMall getFloorArrayInNegativeSequence:YES] retain];
    
    [self.mFloorSwitcher setDelegate:self];
    self.mFloorSwitcher.dataSource = self;
    [self.view addSubview:self.mFloorSwitcher];
}

-(void)onFloorSelected:(NSString *)strFloor {
    if (mFloorSwitcher) {
        for (int i = 0; i < [floorInforArray count]; i++) {
            NSString *floorID = [floorInforArray objectAtIndex:i];
            if ([floorID isEqualToString:strFloor]) {
                if ([self.mFloorSwitcher.indexPathForSelectedRow row] != i) {
                    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.mFloorSwitcher selectRowAtIndexPath:newIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
                }
                
                break;
            }
        }
    }
}

-(void)hideFloorSwitcherIfNeeded {
    //don't need to hide
}

-(void)willLoadMapData {
    
    [SVProgressHUD showInView:self.view status:@"正在加载地图..."];
    
}

-(void)didLoadMapDataSuccessfully {
    [SVProgressHUD dismissAfterDelay:0.8];
}

-(void)didLoadMapDataFailed {
    [SVProgressHUD showErrorinView:self.view withStatus:@"获取服务器数据失败!" switchToNormalInforAfterDelay:5];
}


-(void)updateDownloadPercentage:(int)percentage {
    NSString *status = [NSString stringWithFormat:@"%d%%", percentage];
    [SVProgressHUD setStatus:status];
}

-(void)updateZoomInBtn:(BOOL)enabled {
    [self.zoomInBtn setEnabled:enabled];
}

-(void)updateZoomOutBtn:(BOOL)enabled {
    [self.zoomOutBtn setEnabled:enabled];
}

#pragma mark - ZoomIn & ZoomOut button
-(void)createZoomButtons
{
    int startX = self.view.frame.size.width - 150;
    int startY = self.view.frame.size.height - 100;
    
    //create a container to make sure touch actions for zoom button will not send to MapControl
    UILabel *zoomButtonContainer = [[[UILabel alloc] initWithFrame:CGRectMake(startX, startY, 90, 40)] autorelease];
    zoomButtonContainer.backgroundColor = [UIColor clearColor];
    [zoomButtonContainer setEnabled:YES];
    zoomButtonContainer.userInteractionEnabled = YES;
    [zoomButtonContainer setMultipleTouchEnabled:YES];
    
    UIButton *zoomInBtnTmp = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.zoomInBtn = zoomInBtnTmp;
    [zoomInBtnTmp release];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zoom_in_enable" ofType:@"png"];
    [self.zoomInBtn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    
    [self.zoomInBtn addTarget:self action:@selector(zoomInMap) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *zoomOutBtnTmp = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 40, 40)];
    self.zoomOutBtn = zoomOutBtnTmp;
    [zoomOutBtnTmp release];
    
    path = [[NSBundle mainBundle] pathForResource:@"zoom_out_enable" ofType:@"png"];
    [self.zoomOutBtn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    [self.zoomOutBtn addTarget:self action:@selector(zoomOutMap) forControlEvents:UIControlEventTouchUpInside];
    
    [zoomButtonContainer addSubview:self.zoomInBtn];
    [zoomButtonContainer addSubview:self.zoomOutBtn];
    [self.view insertSubview:zoomButtonContainer aboveSubview:self.mMapControl.view];
}

-(void)zoomInMap {
    [self.mMapControl zoomInMap];
}

-(void)zoomOutMap {
    [self.mMapControl zoomOutMap];
}

#pragma mark - other methods
-(void)setColors {
    
}

@end
