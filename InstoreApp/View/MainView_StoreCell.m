//
//  MainView_ StoreCell.m
//  InstoreApp
//
//  Created by evil on 14-6-9.
//  Copyright (c) 2014年 evil. All rights reserved.
//

#import "MainView_StoreCell.h"
#import "EGOImageView.h"
#import "StoreModel.h"

#import "AppDelegate.h"
#import "StoreDetail_RestaurantViewController.h"


@implementation MainView_StoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataList:(NSArray *)dataList
{
    [_dataList release];
    _dataList = [dataList retain];
    
    for (NSInteger i = 0; i < self.dataList.count; i++) {
        StoreModel *sm = [self.dataList objectAtIndex:i];
        
        EGOImageView *imageView = [[[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)] autorelease];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.layer.cornerRadius = 4;
        imageView.layer.borderWidth = 0.4f;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageView.clipsToBounds = YES;
        imageView.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/100*100.png",sm.imageUrl]];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(tapAction:)] autorelease];
        [imageView addGestureRecognizer:tap];
        
        CGRect frame = imageView.frame ;
        if (i < 5) {
            frame.origin.x = i * (56 + 5);
        }else{
            frame.origin.y = 56 + 10;
            frame.origin.x = (i - 5) * (56 + 5);
        }
        
        imageView.frame = frame;
        
        [self.parentView addSubview:imageView];
    }
}

-(void)tapAction:(UIGestureRecognizer *)gesture
{
    UIView *v = gesture.view;
    StoreModel *sm = [self.dataList objectAtIndex:v.tag];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:248.0f/255.0f green:40.0f/255.0f blue:53.0f/255.0f alpha:1]];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    StoreDetail_RestaurantViewController *vc = [[[StoreDetail_RestaurantViewController alloc] initWithNibName:@"StoreDetail_RestaurantViewController" bundle:nil] autorelease];
    
    [vc setShopId:sm.sid];
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}

-(IBAction)moreBtnAction:(id)sender{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.tabBarController setSelectedIndex:3];
}


-(void)dealloc
{
    self.titleLabel = nil;
    self.parentView = nil;
    self.dataList = nil;
    
    [super dealloc];
}
@end
