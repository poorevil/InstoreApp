//
//  SearchViewController.m
//  InstoreApp
//
//  Created by han chao on 14-4-2.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultViewController.h"
#import "SearchHotKeywordAndHistoryInterface.h"
#import "SearchClearHistoryInterface.h"

@interface SearchViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SearchHotKeywordInterfaceDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;

@property (retain, nonatomic) SearchHotKeywordAndHistoryInterface *searchHotKeywordAndHistoryInterface;
@property (retain, nonatomic) NSArray *hotKeyWordList;
@property (retain, nonatomic) NSArray *historyList;
@property (retain, nonatomic) SearchClearHistoryInterface *searchClearHistoryInterface;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f
                                                                             green:40.0f/255.0f
                                                                              blue:53.0f/255.0f
                                                                             alpha:1]];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    cancelBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = cancelBtn;
    
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectZero] autorelease];
    self.searchBar.placeholder = @"请输入关键词";
    self.searchBar.delegate = self;

    [self.searchBar setTintColor:[UIColor lightGrayColor]];
//    [self.searchBar setSearchTextPositionAdjustment:UIOffsetMake(30, 0)];// 设置搜索框中文本框的文本偏移量
    [self.searchBar sizeToFit];

    self.navigationItem.titleView = self.searchBar;
//    [self.searchBar becomeFirstResponder];
    
    self.searchHotKeywordAndHistoryInterface = [[[SearchHotKeywordAndHistoryInterface alloc]init]autorelease];
    self.searchHotKeywordAndHistoryInterface.delegate = self;
    [self.searchHotKeywordAndHistoryInterface getSearchHotKeywordAndHistoryList];
    
    self.searchClearHistoryInterface = [[[SearchClearHistoryInterface alloc]init]autorelease];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(void)cancelAction
{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
        [self.navigationItem.rightBarButtonItem setTitle:@"关闭"];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
        cell.textLabel.textColor = [UIColor colorWithRed:106/255.0f
                                                   green:106/255.0f
                                                    blue:106/255.0f
                                                   alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if (indexPath.row == self.historyList.count ) {
        cell.textLabel.text = @"                                清空搜索记录";
//        cell.textLabel.center = CGPointMake(160, 22);
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }else{
        cell.textLabel.text = [self.historyList objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.historyList.count ) {
        self.historyList = nil;
        [self.mtableView reloadData];
        //服务器请求：清空历史记录
        [self.searchClearHistoryInterface clearHistoty];
        
    }else{
        SearchResultViewController *searchResultViewController = [[[SearchResultViewController alloc] init] autorelease];
        searchResultViewController.searchKeyWord = [self.historyList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:searchResultViewController animated:NO];
    }
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.navigationItem.rightBarButtonItem setTitle:@"取消"];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    SearchResultViewController *searchResultViewController = [[[SearchResultViewController alloc] init] autorelease];
    searchResultViewController.searchKeyWord = self.searchBar.text;
    [self.navigationController pushViewController:searchResultViewController animated:NO];
    
}

#pragma mark - SearchHotKeywordInterfaceDelegate <NSObject>
-(void)getSearchHotKeywordAndHistoryListDidFinished:(NSArray *)hot AndHistory:(NSArray *)history{
    self.hotKeyWordList = hot;
    [self.btnHotWord1 setTitle:[hot objectAtIndex:0] forState:UIControlStateNormal];
    [self.btnHotWord2 setTitle:[hot objectAtIndex:1] forState:UIControlStateNormal];
    [self.btnHotWord3 setTitle:[hot objectAtIndex:2] forState:UIControlStateNormal];
    
    self.historyList = history;
    [self.mtableView reloadData];
}
-(void)getSearchHotKeywordAndHistoryListListDidFailed:(NSString *)errorMsg{
    NSLog(@"%@",errorMsg);
}

-(void)dealloc
{
    self.mtableView = nil;
    self.searchBar = nil;
    
    self.hotKeyWordList = nil;
    self.historyList = nil;
    
    self.searchHotKeywordAndHistoryInterface = nil;
    self.searchClearHistoryInterface = nil;
    
    [_btnHotWord1 release];
    [_btnHotWord2 release];
    [_btnHotWord3 release];
    [super dealloc];
}

- (IBAction)btnHotSearchAction:(UIButton *)sender {
    SearchResultViewController *searchResultViewController = [[[SearchResultViewController alloc] init] autorelease];
    searchResultViewController.searchKeyWord = sender.titleLabel.text;
    [self.navigationController pushViewController:searchResultViewController animated:NO];
}
@end
