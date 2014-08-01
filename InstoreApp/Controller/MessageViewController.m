//
//  MessageViewController.m
//  InstoreApp
//
//  Created by Mac on 14-7-25.
//  Copyright (c) 2014年 evil. All rights reserved.
//


#import "MessageViewController.h"
#import "MessageViewCell.h"
#import "NSDate+DynamicDateString.h"
#import "MessageInterface.h"
#import "MessageModel.h"
#import "MessageDetailViewController.h"

@interface MessageViewController ()<MessageInterfaceDelegate>

@property (retain, nonatomic) NSMutableArray *itemList;
@property (assign, nonatomic) NSInteger totalCount;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger everyPageCount;

@property (retain, nonatomic) MessageInterface *messageInterface;


@end

@implementation MessageViewController

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
    
    self.title = @"我的消息";
    self.hidesBottomBarWhenPushed = YES;
    self.itemList = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = nil;
    
    self.messageInterface = [[[MessageInterface alloc]init]autorelease];
    self.messageInterface.delegate = self;
    self.currentPage = 1;
    self.everyPageCount = 10;
    [self.messageInterface getMessageInterfaceListByPage:self.currentPage amount:self.everyPageCount];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    MessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MessageViewCell" owner:self options:nil] objectAtIndex:0];
    }
    MessageModel *messageModel = [self.itemList objectAtIndex:indexPath.row];
    
    cell.labTitle.text = messageModel.title;
    cell.labDescription.text = messageModel.summary;
    cell.labDate.text = [messageModel.createDate toDateString];
    
    if (indexPath.row == self.itemList.count -1) {
        if (self.currentPage * self.everyPageCount < self.totalCount) {
            self.currentPage++;
            [self.messageInterface getMessageInterfaceListByPage:self.currentPage amount:self.everyPageCount];
        }
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageDetailViewController *vc = [[MessageDetailViewController alloc]initWithNibName:@"MessageDetailViewController" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    vc.messageModel = [self.itemList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

#pragma mark - MessageInterfaceDelegate <NSObject>
-(void)getMessageInterfaceListDidFinished:(NSArray *)itemList totalCount:(NSInteger)totalCount currentPage:(NSInteger)currentPage{
    [self.itemList addObjectsFromArray:itemList];
    
    [self.myTableView reloadData];
}
-(void)getMessageInterfaceListDidFailed:(NSString *)errorMsg{
    NSLog(@"%s:%@",__FUNCTION__,errorMsg);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myTableView release];
    self.itemList = nil;
    self.messageInterface.delegate = nil;
    self.messageInterface = nil;
    
    [super dealloc];
}
@end
