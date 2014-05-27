//
//  ServiceViewCell.m
//  InstoreApp
//
//  Created by han chao on 14-3-30.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "ServiceViewCell.h"
#import "ServiceModel.h"
#import "EGOImageButton.h"

@implementation ServiceViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [self setBtnStyle:self.foodBtn];
    [self setBtnStyle:self.busBtn];
    [self setBtnStyle:self.moneyBtn];
    [self setBtnStyle:self.planeBtn];
    [self setBtnStyle:self.paintBtn];
    [self setBtnStyle:self.gameBtn];
}

-(void)setServiceList:(NSArray *)serviceList
{
    _serviceList = serviceList;
    
    for (UIView *v in self.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    [self initViews];
}

-(void)initViews
{
    CGPoint anchorPoint = CGPointMake(20, 16);
    CGFloat btnWidth = 60;
    CGFloat marginRight = 14;
    CGFloat marginTop = 8;
    NSInteger numPerRow = 4;
    
    for (NSInteger i=0;i<self.serviceList.count;i++) {
        ServiceModel *service = [self.serviceList objectAtIndex:i];
        
        EGOImageButton *btn = [EGOImageButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(anchorPoint.x + btnWidth*(i%numPerRow) + marginRight*(i%numPerRow),
                               anchorPoint.y + btnWidth*(i/numPerRow) + marginTop*(i/numPerRow),
                               btnWidth, btnWidth);
        btn.tag = i;
        [btn setTitle:service.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:105.0f/255.0f
                                           green:105.0f/255.0f
                                            blue:105.0f/255.0f
                                           alpha:1]
                  forState:UIControlStateNormal];
        btn.imageURL = [NSURL URLWithString:service.picUrl];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setBtnStyle:btn];
        [self.contentView addSubview:btn];
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - private method
-(void)setBtnStyle:(UIButton *)btn
{
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0,
//                                             (btn.frame.size.width-btn.imageView.frame.size.width)/2,
//                                             (btn.frame.size.height-btn.imageView.frame.size.height)/2 +5,
//                                             0)];
//    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height +5,
//                                             -btn.imageView.frame.size.width,
//                                             0, 0)];
    
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0,
                                             (btn.frame.size.width-btn.imageView.frame.size.width)/2,
                                             (btn.frame.size.height-btn.imageView.frame.size.height)/2 +5,
                                             0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.frame.size.height -20,
                                             -btn.frame.size.width,
                                             0, 0)];
    
//    btn.backgroundColor = [UIColor blackColor];
}

-(void)btnAction:(id)sender
{
    if ([sender isMemberOfClass:[EGOImageButton class]]) {
        EGOImageButton *btn = sender;
        ServiceModel *service = [self.serviceList objectAtIndex:btn.tag];
        
        //TODO:对应操作
        NSLog(@"btnAction-------%@",service.name);
    }
}

-(void)dealloc
{
    self.foodBtn = nil;
    self.busBtn = nil;
    self.moneyBtn = nil;
    self.planeBtn = nil;
    self.paintBtn = nil;
    self.gameBtn = nil;
    self.serviceList = nil;
    
    [super dealloc];
}

@end
