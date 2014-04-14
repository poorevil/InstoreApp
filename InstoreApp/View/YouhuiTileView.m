//
//  YouhuiTileView.m
//  InstoreApp
//
//  Created by han chao on 14-3-28.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "YouhuiTileView.h"
#import "CouponDetailViewController.h"
#import "AppDelegate.h"

@implementation YouhuiTileView
#define MARGIN 4.0
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)awakeFromNib
{
    self.picView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.picView addGestureRecognizer:tap];

    self.viewGroup.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.7].CGColor;
    self.viewGroup.layer.borderWidth = 0.5f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)tapAction:(UIGestureRecognizer *) gesture
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    CouponDetailViewController *cdvc = [[CouponDetailViewController alloc] initWithNibName:@"CouponDetailViewController" bundle:nil];
    cdvc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:cdvc animated:YES];
    cdvc.hidesBottomBarWhenPushed = NO;
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];

    self.iconView.image = [UIImage imageNamed:[object objectForKey:@"icon"]];
    self.picView.image = [UIImage imageNamed:[object objectForKey:@"image"]];
    self.titleLabel.text = [object objectForKey:@"title"];
    
    //计算高度
    CGFloat diffHeight = 0;
    CGFloat width = self.bounds.size.width;
    // Image
    CGFloat objectWidth = [[object objectForKey:@"width"] floatValue];
    CGFloat objectHeight = [[object objectForKey:@"height"] floatValue];
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    
    diffHeight += (scaledHeight - self.picView.frame.size.height);
    
    self.picView.frame = CGRectMake(self.picView.frame.origin.x,
                                    self.picView.frame.origin.y,
                                    self.picView.frame.size.width,
                                    self.picView.frame.size.height + diffHeight);
    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x,
                                       self.titleLabel.frame.origin.y + diffHeight,
                                       self.titleLabel.frame.size.width,
                                       self.titleLabel.frame.size.height);
    self.buttonGroup.frame = CGRectMake(self.buttonGroup.frame.origin.x,
                                       self.buttonGroup.frame.origin.y + diffHeight,
                                       self.buttonGroup.frame.size.width,
                                       self.buttonGroup.frame.size.height);
    self.viewGroup.frame = CGRectMake(self.viewGroup.frame.origin.x,
                                        self.viewGroup.frame.origin.y,
                                        self.viewGroup.frame.size.width,
                                        self.viewGroup.frame.size.height + diffHeight);
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height + diffHeight);
    
    
    
}


+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    
    //计算高度
    CGFloat diffHeight = 0;
    CGFloat width = columnWidth;
    // Image
    CGFloat objectWidth = [[object objectForKey:@"width"] floatValue];
    CGFloat objectHeight = [[object objectForKey:@"height"] floatValue];
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    
    diffHeight += (scaledHeight - 99);
    
    return 221 + diffHeight;
}

@end
