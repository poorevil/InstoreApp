//
//  MallNews_multiCell.m
//  InstoreApp
//
//  Created by Mac on 14-7-29.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MallNews_multiCell.h"
#import "MallNewsModel.h"
#import "MallNews_multiCell_cellView.h"
#import "NSDate+DynamicDateString.h"
#import "WebViewController.h"
#import "AppDelegate.h"

@implementation MallNews_multiCell

- (void)awakeFromNib
{
    // Initialization code
    self.parentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.parentView.layer.borderWidth = 0.4f;
}

-(void)setDict:(NSDictionary *)dict
{
    [_dict release];
    _dict = [dict retain];
    
    NSString *dateStr = [self.dict objectForKey:@"date"];
    self.dateLabel.text = dateStr == nil?@"":[[NSDate dateFromString:dateStr] toDateString];
    
    NSArray *articles = [self.dict objectForKey:@"articles"];
    MallNewsModel *mnm = [articles objectAtIndex:0];
    self.titleLabel.text = mnm.title;
    self.articleImageView.imageURL = [NSURL URLWithString:mnm.image];
    
    for (int i = 1; i < articles.count; i++) {
        MallNews_multiCell_cellView *view = [[[NSBundle mainBundle] loadNibNamed:@"MallNews_multiCell_cellView" owner:self options:nil]objectAtIndex:0];
        view.frame = CGRectMake(0, 160 + (i-1) * 66, 310, 66);
        MallNewsModel *model = [articles objectAtIndex:i];
        view.titleLabel.text = model.title;
        view.articleImageView.imageURL = [NSURL URLWithString:model.image];
//        view.url = model.url;
        [self.parentView addSubview:view];
        [view release];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
        [tap release];
    }
    
    if (articles.count > 1) {
        CGRect frame1 = self.parentView.frame;
        frame1.size.height = (articles.count-1)*66 + 160;
        self.parentView.frame = frame1;
    }
}
-(void)tapAction:(UIGestureRecognizer *)gesture
{
    MallNews_multiCell_cellView *view = (MallNews_multiCell_cellView *)gesture.view;
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.hidesBottomBarWhenPushed = YES;
    webVC.urlStr = view.url;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    [nav pushViewController:webVC animated:YES];
    [webVC release];
}

-(void)dealloc{
    self.titleLabel = nil;
    self.articleImageView = nil;
    self.dateLabel = nil;
    self.dict = nil;
    self.parentView = nil;
    
    [super dealloc];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
